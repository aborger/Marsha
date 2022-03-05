#!/usr/bin/env python

import rospy

from std_msgs.msg import Empty



def reset_sim():
    reset_pub = rospy.Publisher('/reset', Empty, queue_size=5)
    reset_pub.publish()