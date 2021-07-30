#!/usr/bin/env python

import rospy
from std_msgs.msg import Float64
from std_msgs.msg import Bool
import math
import sys

DEGREE_ERROR = 10

class PID(object):
    def __init__(self):
        rospy.init_node('pid', log_level=rospy.DEBUG)
        rospy.loginfo('Starting')
        ns = rospy.get_namespace()
        self.setpoint = 0
        self.state = 0

        self.pub = rospy.Publisher(ns + 'control_effort', Float64, queue_size=10)
        self.pub_status = rospy.Publisher(ns + 'episode_status', Bool, queue_size=2)
        rospy.Subscriber(ns + 'setpoint', Float64, self.setpointCallBack)
        rospy.Subscriber(ns + 'state', Float64, self.stateCallBack)
        self.rate = rospy.Rate(10)
        #rospy.spin()

    def setpointCallBack(self, msg):
        self.setpoint = msg.data

    def stateCallBack(self, msg):
        self.state = msg.data

    def calculate(self):
        error = self.setpoint - self.state
        if error < 5 and error > -5:
            self.pub_status.publish(True)
        else:
            rospy.logdebug('Error: ' + str(error))

            effort =  200/(1+math.exp(-0.01 *error)) -100

            self.pub.publish(effort)

    def run(self):
        while not rospy.is_shutdown():
            self.calculate()
            self.rate.sleep()

if __name__ == "__main__":
    print(sys.version)

    try:
        pid = PID()
        pid.run()
        rospy.spin()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')

