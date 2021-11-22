#!/usr/bin/env python

import rospy
from trajectory_msgs.msg import JointTrajectory

def callback(data):
    print(data)

def main():
    rospy.init_node('listener')
    rospy.Subscriber('/left/ar3/controllers/position/command', JointTrajectory, callback)
    print('Spinning...')

    rospy.spin()

if __name__ == '__main__':
    main()