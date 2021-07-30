#!/usr/bin/env python3
import rospy
import os
from std_msgs.msg import Float64
import sys
import tensorflow as tf


def msgCallBack(msg):
    rospy.loginfo(sys.version)
    rospy.loginfo(msg)
    

def listener():
    rospy.init_node('listener', log_level=rospy.DEBUG)
    rospy.Subscriber('state', Float64, msgCallBack) # change this to listen to any topic

    rospy.spin()


if __name__ == "__main__":

    listener()