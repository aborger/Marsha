#!/usr/bin/env python3

import rospy

from geometry_msgs.msg import Pose
from geometry_msgs.msg import Point
from marsha_ai.srv import MoveCmd
from marsha_ai.srv import GetPose
from marsha_ai.srv import PositionCmd
import numpy as np
from std_srvs.srv import Trigger, TriggerRequest
from std_msgs.msg import String


from marsha_ai.ros_interface import RosInterface

from time import sleep

import math

STEP_SIZE = 0.04

def calculateDistance(p1, p2):
    distance = math.sqrt((p2.x - p1.x)**2 + (p2.y - p1.y)**2 + (p2.z - p1.z)**2)
    return distance

class CatchInterface(RosInterface):
    def __init__(self):
        super(CatchInterface, self).__init__()

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

        self.last_50_rewards = []
        self.grasp_successful = False # Tracks if a grasp was succesfull during the episode
        self.progress_pub = rospy.Publisher('/ai_progress', String, queue_size=10)


        rospy.logdebug('Interface Started!')

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

        # As stated in gym_env.py MarshaGym.__init__
        # Current actions has shape (8)
        # where action[0,1] corresponds to a step in the x axis
        # action[2,3] corresponds to a step in the y axis
        # action[4,5] corresponds to a step in the z axis
        # action[6] closes the gripper
        # action[7] opens the gripper

        rospy.logdebug("Performing action...")
        rospy.logdebug(action)
        position = self.getPos().position
        
        if action == 0:
            position.x += STEP_SIZE
        elif action == 1:
            position.x -= STEP_SIZE
        elif action == 2:
            position.y += STEP_SIZE
        elif action == 3:
            position.y -= STEP_SIZE
        elif action == 4:
            position.z += STEP_SIZE
        elif action == 5:
            position.z -= STEP_SIZE
        elif action == 6:
            self.graspCmd("close")
        else:
            self.graspCmd("open")

    

        # Move
        success = self.positionCmd(position).done

        rospy.logdebug("Action Success: " + str(success))

        goal_position = Point(-0.25677, -0.0545, 0.115)


        reward = 1 / calculateDistance(position, goal_position)

        if success:
            reward *= 2
        else:
            reward *= 0.5

        grasped = self.isGrasped().success

        if grasped:
            reward *= 10
            self.grasp_successful = True

        rospy.logdebug("Reward: " + str(reward))

        self.last_50_rewards.append(reward)

        if len(self.last_50_rewards) > 50:
            self.last_50_rewards.pop(0)

        done = grasped
        return done, reward

    def observe(self):
        rospy.logdebug("Observing...")
        position = self._get_object_position()

        observation = np.zeros(shape=(3,))
        observation[0] = position.x
        observation[1] = position.y
        observation[2] = position.z

        return observation

    
    def reset_simulation(self):
        rospy.logdebug("Resetting...")
        success = self.poseCmd("preGrasp")
        self.graspCmd("open")
        self.grasp_successful = False

        self.reset(TriggerRequest())

    def log_progress(self):
        sum = 0
        for reward in self.last_50_rewards:
            sum += reward
        avg = sum / len(self.last_50_rewards)
        rospy.logdebug("Average Reward" + str(avg))

        if self.grasp_successful:
            self.progress_pub.publish("Average Reward: " + str(avg))
        else:
            self.progress_pub.publish("Object Grasped! Average Reward: " + str(avg))

        
    

def main():
    interface = CatchInterface()


if __name__ == '__main__':
    main()







