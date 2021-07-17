#!/usr/bin/env python
import rospy
import os
from marsha.msg import Log


def logCallBack(msg):
    if msg.logLevel is 0:
        rospy.logdebug(msg.msg)
    elif msg.logLevel is 1:
        rospy.loginfo(msg.msg)
    elif msg.logLevel is 2:
        rospy.logwarn(msg.msg)
    elif msg.logLevel is 3:
        rospy.logerr(msg.msg)
    elif msg.logLevel is 4:
        rospy.logfatal(msg.msg)
        os.system("rosnode list | grep -v rqt | xargs rosnode kill")
        #os.system("sudo shutdown -h now")

        #os.system("killall -9 rosmaster")
    

def listener():
    rospy.init_node('Log_listener', log_level=rospy.DEBUG)
    rospy.Subscriber('bridgeLog', Log, logCallBack)

    rospy.spin()


if __name__ == "__main__":

    listener()