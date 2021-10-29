#!/usr/bin/env python3

import rospy

from geometry_msgs.msg import Pose
from geometry_msgs.msg import Point
from marsha_ai.srv import MoveCmd
from marsha_ai.srv import GetPose
from marsha_ai.srv import PositionCmd
import numpy as np
from std_srvs.srv import Trigger, TriggerRequest

from time import sleep

import math



def calculateDistance(p1, p2):
    distance = math.sqrt((p2.x - p1.x)**2 + (p2.y - p1.y)**2 + (p2.z - p1.z)**2)
    return distance

class RosInterface():
    def __init__(self):
        rospy.init_node('AI_ros_interface')
        rospy.loginfo('Interface starting...')

        rospy.wait_for_service('/left/position_cmd')
        self.positionCmd = rospy.ServiceProxy('/left/position_cmd', PositionCmd)

        rospy.wait_for_service('/left/get_pos')
        self.getPos = rospy.ServiceProxy('/left/get_pos', GetPose)

        rospy.wait_for_service('/reset')
        self.reset = rospy.ServiceProxy('/reset', Trigger)

        rospy.wait_for_service('/left/pose_cmd')
        self.poseCmd = rospy.ServiceProxy('/left/pose_cmd', MoveCmd)

        rospy.wait_for_service('/get_object_pos')
        self.objectPos = rospy.ServiceProxy('/get_object_pos', GetPose)

        rospy.wait_for_service('/left/grasp_cmd')
        self.graspCmd = rospy.ServiceProxy('/left/grasp_cmd', MoveCmd)

        rospy.wait_for_service('/left/is_grasped')
        self.isGrasped = rospy.ServiceProxy('/left/is_grasped', Trigger)


        rospy.logdebug('object_pos...')


        rospy.loginfo('Interface Started!')

    def _get_object_position(self):
        object_pos = None
        while object_pos == None:
            try:
                object_pos = self.objectPos().position
            except KeyboardInterrupt:
                break
            except:
                rospy.logwarn("Could not communicate!")
                sleep(1)
        return object_pos

    def perform_action(self, action):
        rospy.loginfo("Performing action...")
        rospy.loginfo(action)
        position = self.getPos().position
        

        if action[3] > 1.1:
            self.graspCmd("open")
        if action[3] < 0.9:
            self.graspCmd("close")
        
        # move current position by NN output
        position.x *= action[0]
        position.y *= action[1]
        position.z *= action[2]

        # Move
        success = self.positionCmd(position).done

        rospy.loginfo("Action Success: " + str(success))

        goal_position = Point(-0.25677, -0.0545, 0.115)


        reward = 1 / calculateDistance(position, goal_position)

        if success:
            reward *= 2
        else:
            reward *= 0.5

        grasped = self.isGrasped()

        if grasped:
            reward *= 10

        rospy.loginfo("Reward: " + str(reward))
        done = False
        return done, reward

    def observe(self):
        rospy.loginfo("Observing...")
        position = self._get_object_position()

        observation = np.zeros(shape=(3,1))
        observation[0] = position.x
        observation[1] = position.y
        observation[2] = position.z

        return observation

    
    def reset_simulation(self):
        rospy.loginfo("Resetting...")
        success = self.poseCmd("preGrasp")
        self.graspCmd("open")

        self.reset(TriggerRequest())
        
    

def main():
    interface = RosInterface()


if __name__ == '__main__':
    main()







