#!/usr/bin/env python3

import rospy

from marsha_ai.ros_interface import RosInterface

from marsha_msgs.srv import GenerateGrasp
from marsha_msgs.srv import PostureCmd
from marsha_msgs.srv import PredictPosition
from marsha_msgs.srv import GetPos
from marsha_msgs.srv import MoveCmd
from marsha_msgs.srv import PlanGrasp
from marsha_msgs.srv import ObjectObservation

from std_msgs.msg import Empty
from std_msgs.msg import Time
from std_msgs.msg import Float32

from std_srvs.srv import Trigger, TriggerRequest

from geometry_msgs.msg import Pose

from time import sleep

import numpy as np
import math

PRE_GRASP_DISTANCE = 2
POST_GRASP_DISTANCE = 0.5 # May want to learn this

DEBUG = True

def object_to_world(obj_space, obj_pos):
    world = Pose()
    world.position.x = obj_pos.x + obj_space.position.x
    world.position.y = obj_pos.y + obj_space.position.y
    world.position.z = obj_pos.z + obj_space.position.z
    world.orientation = obj_space.orientation
    return world

def distance(pose1: Pose, pose2: Pose):
    dist = math.sqrt((pose1.position.x - pose2.position.x)**2 +
                     (pose1.position.y - pose2.position.y)**2 +
                     (pose1.position.z - pose2.position.z)**2)
    return dist

class CatchInterface(RosInterface):
    """
    CatchInterface provides an interface between the OpenAI gym environment and ROS.
    """
    def __init__(self):
        super(CatchInterface, self).__init__()

        rospy.loginfo("Waiting for services...")

        rospy.wait_for_service('generate_grasp')
        self.generate_grasp = rospy.ServiceProxy('generate_grasp', GenerateGrasp)

        rospy.wait_for_service('/left/posture_cmd')
        self.posture_cmd = rospy.ServiceProxy('/left/posture_cmd', PostureCmd)

        rospy.wait_for_service('/left/plan_grasp')
        self.plan_grasp = rospy.ServiceProxy('/left/plan_grasp', PlanGrasp)

        rospy.wait_for_service('predict_position')
        self.predict_position = rospy.ServiceProxy('predict_position', PredictPosition)

        rospy.wait_for_service('/left/get_pos')
        self.get_pos = rospy.ServiceProxy('/left/get_pos', GetPos)

        rospy.wait_for_service('/left/gripper/grasp_cmd')
        self.grasp_cmd = rospy.ServiceProxy('/left/gripper/grasp_cmd', MoveCmd)

        rospy.wait_for_service('/left/gripper/is_grasped')
        self.is_grasped = rospy.ServiceProxy('/left/gripper/is_grasped', Trigger)

        rospy.wait_for_service('observe_trajectory')
        self.observe = rospy.ServiceProxy('observe_trajectory', ObjectObservation)

        rospy.loginfo("Services setup!")

        self.reset_pub = rospy.Publisher("/reset", Empty, queue_size=10)

        self.reset_pub.publish()

    # action_space (r, theta, phi, time)
    def perform_action(self, action):
        reward = 0
        if DEBUG:
            rospy.loginfo("Actions: R:" + str(action[0]) + " theta: " + str(action[1]) + " phi: " + str(action[2]) + " slice: " + str(action[3]) + " t_offset: " + str(action[4]) + " grasp_time: " + str(action[5]))

        # Grasp generator takes "tailored latent space" as input
        obj_space_preGrasp = self.generate_grasp(action[0] + PRE_GRASP_DISTANCE, action[1], action[2]).grasp
        obj_space_grasp = self.generate_grasp(action[0] - POST_GRASP_DISTANCE, action[1], action[2]).grasp

        # Calculate object position at output time
        prediction = self.predict_position(norm_dist=action[3])
        

        pre_grasp = object_to_world(obj_space_preGrasp, prediction.position)
        grasp = object_to_world(obj_space_grasp, prediction.position)

        # Note: action[4] is currently on range (0, 1) so therefore it will only begin the grasp before it reaches the desired point
        grasp_time = Time(prediction.predicted_time.data - rospy.Duration(action[4]))

        #time_until = grasp_time - rospy.Time.now()
        #print("Time until predicted:", time_until)

        # TODO:  Check ball location before finishing grasp / take into account time arm takes to move
        move_success = self.plan_grasp(pre_grasp, grasp, grasp_time, Float32(action[5])).success

        if DEBUG:
            print("Move Success:", move_success)

        dist_at_grasp = distance(self.observe(), grasp)
        
        # Punish if ball is further away
        reward -= dist_at_grasp
        
        

        if move_success:
            sleep(2)
        else:
            reward -= 1


        catch_success = self.is_grasped().success
        if DEBUG:
            print("Catch success: ", catch_success)

        if catch_success:
            sleep(1)
            self.grasp_cmd("open")
            sleep(1)
            reward = 10

        return reward, move_success



    def perform_observation(self):
        raw_observation = self.observe()
        observation = np.empty(shape=(2, 3))
        observation[0, 0] = raw_observation.position.x
        observation[0, 1] = raw_observation.position.y
        observation[0, 2] = raw_observation.position.z
        observation[1, 0] = raw_observation.velocity.x
        observation[1, 1] = raw_observation.velocity.y
        observation[1, 2] = raw_observation.velocity.z
        if DEBUG:
            print("Observation:\n", observation)
        return observation

    def reset_simulation(self):
        if DEBUG:
            print("resetting...")
        self.reset_pub.publish()




