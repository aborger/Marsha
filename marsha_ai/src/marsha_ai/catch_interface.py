#!/usr/bin/env python3

import rospy

from geometry_msgs.msg import Pose
from geometry_msgs.msg import Point
from marsha_ai.srv import MoveCmd
from marsha_msgs.srv import GetPos
from marsha_msgs.srv import GetPosFrame
from marsha_msgs.srv import PositionCmd
#from marsha_msgs.msg import PositionCmdAction, PositionCmdGoal
import numpy as np
from std_srvs.srv import Trigger, TriggerRequest
from std_msgs.msg import String
import actionlib

from marsha_ai.util import func_timer


from marsha_ai.ros_interface import RosInterface

from time import sleep

import math

def calculateDistance(p1, p2):
    distance = math.sqrt((p2.x - p1.x)**2 + (p2.y - p1.y)**2 + (p2.z - p1.z)**2)
    return distance

class CatchInterface(RosInterface):
    def __init__(self):
        super(CatchInterface, self).__init__()

        # ---- These should be actions not services to speed it up
        #self.position_client = actionlib.SimpleActionClient('/left/position_cmd', PositionCmdAction)
        #self.position_client.wait_for_server()

        rospy.wait_for_service('/left/position_cmd')
        self.positionCmd = rospy.ServiceProxy('/left/position_cmd', PositionCmd)

        rospy.wait_for_service('/left/pose_cmd')
        self.poseCmd = rospy.ServiceProxy('/left/pose_cmd', MoveCmd)

        rospy.wait_for_service('/left/grasp_cmd')
        self.graspCmd = rospy.ServiceProxy('/left/grasp_cmd', MoveCmd)
        # ----

        rospy.wait_for_service('/left/get_pos')
        self.getPos = rospy.ServiceProxy('/left/get_pos', GetPos)

        rospy.wait_for_service('/reset')
        self.reset = rospy.ServiceProxy('/reset', Trigger)



        rospy.wait_for_service('/get_object_pos')
        self.objectPos = rospy.ServiceProxy('/get_object_pos', GetPosFrame)


        rospy.wait_for_service('/left/is_grasped')
        self.isGrasped = rospy.ServiceProxy('/left/is_grasped', Trigger)

        self.episode_reward = []
        self.episode_num = 0
        self.grasp_successful = False # Tracks if a grasp was succesfull during the episode
        self.progress_pub = rospy.Publisher('/ai_progress', String, queue_size=10)


        rospy.logdebug('Interface Started!')


    def _get_object_position(self, relative_frame):
        object_pos = None
        while object_pos == None:
            try:
                object_pos = self.objectPos(relative_frame).position
            except KeyboardInterrupt:
                break
            except:
                rospy.logwarn("Could not communicate!")
                sleep(1)
        return object_pos

    @func_timer
    def perform_action(self, action):
        STEP_SIZE = rospy.get_param("/hyperparameters/step_size")

        # As stated in gym_env.py MarshaGym.__init__
        # Current actions has shape (8)
        # where action[0,1] corresponds to a step in the x axis
        # action[2,3] corresponds to a step in the y axis
        # action[4,5] corresponds to a step in the z axis
        # action[6] closes the gripper
        # action[7] opens the gripper


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
        #pos_goal = PositionCmdGoal(position)
        #self.position_client.send_goal(pos_goal)
        @func_timer
        def positionCmd(position):
            return self.positionCmd(position).done
            

        #success = self.positionCmd(position).done
        success = positionCmd(position)


        object_pos = self._get_object_position("world")

        reward = 1 / calculateDistance(position, object_pos)

        grasped = self.isGrasped().success

        if grasped:
            reward *= 10
            self.grasp_successful = True





        done = grasped
        return done, reward

    @func_timer
    def observe(self):
        rospy.logdebug("Observing...")
        position = self._get_object_position("left_ar3::link_6")

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
        self.episode_num += 1
        self.average_rewards = []

        self.reset(TriggerRequest())

    def log_progress(self):
        sum = 0
        for reward in self.average_rewards:
            sum += reward
        avg = sum / len(self.average_rewards)
        rospy.logdebug("Average Reward" + str(avg))

        progress_msg = "[EP " + str(self.episode_num) + "] Average Reward: " + str(avg)

        if self.grasp_successful:
            self.progress_pub.publish(progress_msg + "Object Grasped!")
        else:
            self.progress_pub.publish(progress_msg)

        
    

def main():
    interface = CatchInterface()


if __name__ == '__main__':
    main()







