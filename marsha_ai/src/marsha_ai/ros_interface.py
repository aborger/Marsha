#!/usr/bin/env python3

import rospy

class RosInterface():
    def __init__(self):
        rospy.init_node('AI_ros_interface')


    def perform_action(self, action):
        pass

    def observe(self):
        pass

    def reset_simulation(self):
        pass

    def log_progress(self):
        pass