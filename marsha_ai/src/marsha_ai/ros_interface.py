#!/usr/bin/env python3

import rospy
from marsha_ai.msg import Pos
import numpy as np
from std_srvs.srv import Empty
#import gazebo_msgs.ResetSimulation


class RosInterface():
    def __init__(self):
        rospy.init_node('AI_ros_interface')
        rospy.loginfo('Interface starting...')

        self.pos_pub = rospy.Publisher('AI_pos', Pos, queue_size=10)
        self.rate = rospy.Rate(10)


    def perform_action(self, action):
        msg = Pos()
        msg.x = action[0]
        msg.y = action[1]
        msg.z = action[2]
        self.pos_pub.publish(msg)

    def observe(self):
        return np.zeros(shape=(3,1))

    
    def reset_simulation(self):
        reset_act = [0.0, -0.40, -0.30]
        self.perform_action(reset_act)
        """
        rospy.wait_for_service('/gazebo/reset_simulation')
        try:
            r = rospy.ServiceProxy('/gazebo/reset_simulation', Empty)
            r()
        except rospy.ServiceException as e:
            rospy.logwarn('Reset service call failed: ', e)
        """
    









