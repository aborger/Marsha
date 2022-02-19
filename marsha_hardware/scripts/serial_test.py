#!/usr/bin/env python

import rospy

from std_msgs.msg import Int16

val = 0

def run():
    pub = rospy.Publisher('led', Int16, queue_size=10)
    rospy.init_node('talker')
    rate = rospy.Rate(10)
    val = input("Enter val:")
    while not rospy.is_shutdown():
        rospy.loginfo("Val:" + str(val))
        pub.publish(Int16(int(val)))
        rate.sleep()


if __name__ == "__main__":
    run()
