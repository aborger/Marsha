#!/usr/bin/env python3

import cv2

for i in range(100, 107):
    img_path = "/home/cyborg/catkin_ws/src/marsha/marsha_detection/ai/datasets/val/IMG_0" + str(i) + ".jpg"
    print("Fixing:", img_path)
    img = cv2.imread(img_path)
    cv2.imwrite(img_path, img) 

