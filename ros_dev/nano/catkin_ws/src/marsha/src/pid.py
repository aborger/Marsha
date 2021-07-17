#!/usr/bin/env python

import rospy
from std_msgs.msg import Float64
import math

DEGREE_ERROR = 3

class PID(object):
    def __init__(self):
        rospy.init_node('pid')
        ns = rospy.get_namespace()
        self.setpoint = 0
        self.state = 0

        self.pub = rospy.Publisher(ns + 'control_effort', Float64, queue_size=10)
        rospy.Subscriber(ns + 'setpoint', Float64, self.setpointCallBack)
        rospy.Subscriber(ns + 'state', Float64, self.stateCallBack)
        self.rate = rospy.Rate(10)
        #rospy.spin()

    def setpointCallBack(self, msg):
        self.setpoint = msg.data

    def stateCallBack(self, msg):
        self.state = msg.data

    def calculate(self):
        rospy.logdebug('calculating...')
        error = self.setpoint - self.state
        effort =  2/(1+math.exp(-0.2 *error)) -1
        if error < DEGREE_ERROR and error > -1 * DEGREE_ERROR:
            effort = 0
        self.pub.publish(effort)

    def run(self):
        
        while not rospy.is_shutdown():
            self.calculate()
            self.rate.sleep()
if __name__ == "__main__":
    rospy.loginfo('starting...')
    pid = PID()
    pid.run()
