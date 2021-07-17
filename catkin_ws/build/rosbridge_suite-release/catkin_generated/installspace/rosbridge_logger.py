#!/usr/bin/env python2
import rospy
from std_msgs.msg import String




class RosBridgeLogger(object):
    def __init__(self):
        rospy.init_node('RosBridgeLogger')

        rospy.Subscriber('bridgeLog', String, self.logCallBack)


    def logCallBack(self, msg):
        rospy.loginfo(msg.data)

if __name__ == "__main__":
    try:
        logger = RosBridgeLogger()
        rospy.spin()
    except KeyboardInterrupt:
        rospy.logwarn("Exiting logger.")