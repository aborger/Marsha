#!/usr/bin/env python

import rospy
from marsha_ai.msg import Pos


def go_to_position():
    rospy.init_node('Web_ros_interface')

    pos_pub = rospy.Publisher('/left/pos_cmd', Pos, queue_size=10)

    msg = Pos()
    msg.x = 0.0
    msg.y = -0.5
    msg.z = 0.5

    pos_pub.publish(msg)





