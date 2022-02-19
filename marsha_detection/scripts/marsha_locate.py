#!/usr/bin/env python3
import os
import sys
import numpy as np

from Mask_RCNN.mrcnn.config import Config
from Mask_RCNN.mrcnn import model as modellib, utils


import cv2
from marsha_detection.realsense_camera import *

# Define Constants
PRE_TRAINED_COCO_DIR = "/home/satlab/catkin_ws/src/MRCNN/MaskRCNNModel/pretrained_mask_rcnn_coco.h5"
COCO_DIR = "/home/satlab/catkin_ws/src/MRCNN/keras_to_tensorflow/coco_mrcnn.h5"
BALL_DIR = "/home/satlab/catkin_ws/src/MRCNN/MaskRCNNModel/mask_rcnn_ball_0001.h5"
LOGS_DIR = "/home/satlab/catkin_ws/src/MRCNN/MaskRCNNModel/Mask_RCNN/logs"
MODEL_DIR = COCO_DIR
DETECTION_THRESHOLD = 0.9

CLASSES = []
COLORS = np.random.randint(0, 255, (90, 3))

with open("/home/satlab/catkin_ws/src/MRCNN/ObjectDetection/dnn/classes.txt", "r") as file_object:
    for class_name in file_object.readlines():
        class_name = class_name.strip()
        CLASSES.append(class_name)

class ballConfig(Config):
    """Configuration for training on balls
    Derived from base Config class
    Overides Config values to ball values
    """
    
    NAME = "ball"
    
    IMAGES_PER_GPU = 1
    
    GPU_COUNT = 1

    # Coco has 80 classes
    NUM_CLASSES = 1 + 80

    # Number of required detections per image
    DETECTION_MIN_CONFIDENCE = 0

    USE_MINI_MASK = True



# Load Realsense camera
rs = RealsenseCamera()

############################################################
#  RLE Encoding
############################################################

def rle_encode(mask):
    """Encodes a mask in Run Length Encoding (RLE).
    Returns a string of space-separated values.
    """
    assert mask.ndim == 2, "Mask must be of shape [Height, Width]"
    # Flatten it column wise
    m = mask.T.flatten()
    # Compute gradient. Equals 1 or -1 at transition points
    g = np.diff(np.concatenate([[0], m, [0]]), n=1)
    # 1-based indicies of transition points (where gradient != 0)
    rle = np.where(g != 0)[0].reshape([-1, 2]) + 1
    # Convert second index in each pair to lenth
    rle[:, 1] = rle[:, 1] - rle[:, 0]
    return " ".join(map(str, rle.flatten()))


def rle_decode(rle, shape):
    """Decodes an RLE encoded list of space separated
    numbers and returns a binary mask."""
    rle = list(map(int, rle.split()))
    rle = np.array(rle, dtype=np.int32).reshape([-1, 2])
    rle[:, 1] += rle[:, 0]
    rle -= 1
    mask = np.zeros([shape[0] * shape[1]], np.bool)
    for s, e in rle:
        assert 0 <= s < mask.shape[0]
        assert 1 <= e <= mask.shape[0], "shape: {}  s {}  e {}".format(shape, s, e)
        mask[s:e] = 1
    # Reshape and transpose
    mask = mask.reshape([shape[1], shape[0]]).T
    return mask


def mask_to_rle(image_id, mask, scores):
    "Encodes instance masks to submission format."
    assert mask.ndim == 3, "Mask must be [H, W, count]"
    # If mask is empty, return line with image ID only
    if mask.shape[-1] == 0:
        return "{},".format(image_id)
    # Remove mask overlaps
    # Multiply each instance mask by its score order
    # then take the maximum across the last dimension
    order = np.argsort(scores)[::-1] + 1  # 1-based descending
    mask = np.max(mask * np.reshape(order, [1, 1, -1]), -1)
    # Loop over instance masks
    lines = []
    for o in order:
        m = np.where(mask == o, 1, 0)
        # Skip if empty
        if m.sum() == 0.0:
            continue
        rle = rle_encode(m)
        lines.append("{}, {}".format(image_id, rle))
    return "\n".join(lines)

def draw_box(frame, bounding_boxes, class_ids):
    for box, id in zip(bounding_boxes, class_ids):
        x1, y1, x2, y2 = box
        color = COLORS[id]
        color = (int(color[0]), int(color[1]), int(color[2]))

        # Draw bounding box
        cv2.line(frame, (x1, y1), (x2, y1), color, 1) # Top horizontal
        cv2.line(frame, (x1, y2), (x2, y2), color, 1) # Bottom horizontal
        cv2.line(frame, (x1, y1), (x1, y2), color, 1) # Left vertical
        cv2.line(frame, (x2, y1), (x2, y2), color, 1) # Right vertical


    cv2.imshow("Detection Frame", frame)

def draw_mask(frame, masks):
    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    frame_mask = np.zeros(shape=(masks[0].shape[0], masks[0].shape[1], 3), dtype=np.uint8)
    for mask in masks:
        bw_mask = mask*255
        object_mask = np.zeros(shape=(bw_mask.shape[0], bw_mask.shape[1], 3))
        object_mask[:,:,0] = bw_mask
        object_mask[:,:,1] = bw_mask
        object_mask[:,:,2] = bw_mask

        object_mask = object_mask.astype(np.uint8)  
        single_mask = cv2.bitwise_and(frame, object_mask)
        frame_mask = cv2.bitwise_or(frame_mask, single_mask)

        mask_inv = cv2.bitwise_not(bw_mask)
        mask_inv = mask_inv.astype(np.uint8)
        gray_frame = cv2.bitwise_and(gray_frame, mask_inv)


    gray_frame = np.stack((gray_frame,)*3, axis=-1)

    display_frame = gray_frame + frame_mask


    cv2.imshow('Detection', display_frame)





############################################################
#  Detecting
############################################################

def detect(model, frame):
    # Note: You could detect using multiple frames to speed up
    results = model.detect([frame])[0] # Returns dict with 'rois', 'class_ids', 'scores', 'masks'
    num_detections = results['rois'].shape[0]

    if not num_detections:
        print("Nothing detected...")
    else:
        # Make sure everything is the same size
        assert results['rois'].shape[0] == results['masks'].shape[-1] == results['class_ids'].shape[0]

    print(results['masks'].shape)
    boxes = []
    IDs = []
    masks = []
    for i in range(num_detections):
        if not np.any(results['rois'][i]):
            continue # This instance has no bbox
    
        class_id = results['class_ids'][i] - 1 # in results class_id of 0 is nothing, but in classes 
        class_name = CLASSES[class_id]
        y1, x1, y2, x2 = results['rois'][i]

        frame_height, frame_width, _ = frame.shape

        #x1 = int(x1 * frame_width)
        #y1 = int(y1 * frame_height)
        #x2 = int(x2 * frame_width)
        #y2 = int(y2 * frame_height)

        #rle = mask_to_rle(i, results["masks"], results["scores"])
        
        if results['scores'][i] > DETECTION_THRESHOLD:
            boxes.append([x1, y1, x2, y2])
            IDs.append(class_id)
            masks.append(results['masks'][:,:,i])
            print('Detected', class_name, 'at', '(', y1, x1, y2, x2, ')', 'with confidence', results['scores'][i])
        
    #draw_box(frame, boxes, IDs)
    draw_mask(frame, masks)


    # Note: I don't think rle encoding is usefull here. try looking at mrcnn.visualize.display_instances

    #print("Real Detections:", real_detections)

def load_model():
    config = ballConfig()
    model = modellib.MaskRCNN(mode="inference", config=config, model_dir=LOGS_DIR)
    model.load_weights(COCO_DIR, by_name=True) #, exclude=[
                                               #     "mrcnn_class_logits", "mrcnn_bbox_fc",
                                               #     "mrcnn_bbox", "mrcnn_mask"])
    return model

if __name__ == "__main__":
    model = load_model()

    try:
        while True:
            print('-------------------------------------')
            # Get frame from realsense camera
            ret, bgr_frame, depth_frame = rs.get_frame_stream()

            detect(model, bgr_frame)

            key = cv2.waitKey(1)
            if key == 27:
                break

    except Exception as e:
        raise e
    finally:
        rs.release()
        cv2.destroyAllWindows()

    rs.release()
    cv2.destroyAllWindows()
