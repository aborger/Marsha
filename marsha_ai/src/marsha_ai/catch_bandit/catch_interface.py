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

from std_srvs.srv import Trigger, TriggerRequest

from geometry_msgs.msg import Pose

from time import sleep

import numpy as np

PRE_GRASP_DISTANCE = 2

class CatchInterface(RosInterface):
    def __init__(self):
        super(CatchInterface, self).__init__()

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

        rospy.wait_for_service('/left/grasp_cmd')
        self.grasp_cmd = rospy.ServiceProxy('/left/grasp_cmd', MoveCmd)

        rospy.wait_for_service('/left/is_grasped')
        self.is_grasped = rospy.ServiceProxy('/left/is_grasped', Trigger)

        rospy.wait_for_service('observe')
        self.observe = rospy.ServiceProxy('observe', ObjectObservation)

        self.reset_pub = rospy.Publisher("/reset", Empty, queue_size=10)

        self.reset_pub.publish()

    # action_space (r, theta, phi, time)
    def perform_action(self, action):
        reward = 0
        rospy.loginfo("Actions: R:" + str(action[0]) + " theta: " + str(action[1]) + " phi: " + str(action[2]) + " slice: " + str(action[3]) + " t_offset: " + str(action[4]))

        # Grasp generator takes "tailored latent space" as input
        obj_space_preGrasp = self.generate_grasp(action[0] + PRE_GRASP_DISTANCE, action[1], action[2]).grasp
        obj_space_grasp = self.generate_grasp(action[0], action[1], action[2]).grasp

        # Calculate object position at output time
        prediction = self.predict_position(norm_dist=action[3])
        

        pre_grasp = self._object_to_world(obj_space_preGrasp, prediction.position)
        grasp = self._object_to_world(obj_space_grasp, prediction.position)

        grasp_time = Time(prediction.predicted_time.data - rospy.Duration(action[4]))
        
        move_success = self.plan_grasp(pre_grasp, grasp, grasp_time).success
        
        

        if move_success:
            sleep(2)
        else:
            reward -= 1


        catch_success = self.is_grasped().success
        print("catch success: ", catch_success)

        if catch_success:
            sleep(1)
            self.grasp_cmd("open")
            sleep(1)
            reward += 10

        return reward, move_success



    def perform_observation(self):
        raw_observation = self.observe()
        observation = np.empty(shape=(2, 3))
        observation[0, 0] = raw_observation.initial_position.x
        observation[0, 1] = raw_observation.initial_position.y
        observation[0, 2] = raw_observation.initial_position.z
        observation[1, 0] = raw_observation.velocity.x
        observation[1, 1] = raw_observation.velocity.y
        observation[1, 2] = raw_observation.velocity.z
        return observation

    def reset_simulation(self):
        print("resetting...")
        self.reset_pub.publish()

    def _object_to_world(self, obj_space, obj_pos):
        world = Pose()
        world.position.x = obj_pos.x + obj_space.position.x
        world.position.y = obj_pos.y + obj_space.position.y
        world.position.z = obj_pos.z + obj_space.position.z
        world.orientation = obj_space.orientation
        return world
