#!/usr/bin/env python
import rospy
import os
from marsha.msg import TrainInfo


def msgCallBack(msg):
    rospy.logdebug(msg)
    

def listener():
    rospy.init_node('listener', log_level=rospy.DEBUG)
    rospy.Subscriber('train_info', TrainInfo, msgCallBack) # change this to listen to any topic

    rospy.spin()


if __name__ == "__main__":

    listener()