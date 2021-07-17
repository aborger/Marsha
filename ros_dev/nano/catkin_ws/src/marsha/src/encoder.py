#!/usr/bin/env python

import rospy
from std_msgs.msg import Float64
import RPi.GPIO as GPIO
import Encoder

DEGREE_ERROR = 3
ENC1 = 17
ENC2 = 4

class encoder(object):
    def __init__(self):
        rospy.init_node('encoder', log_level=rospy.DEBUG)
        rospy.loginfo('starting...')
        ns = rospy.get_namespace()
        self.state = 0

        GPIO.setmode(GPIO.BCM)

        self.enc = Encoder.Encoder(ENC1, ENC2)
        self.pub = rospy.Publisher(ns + 'state', Float64, queue_size=10)
        self.rate = rospy.Rate(100)


    def run(self):
        error = -1
        while not rospy.is_shutdown():
            newPos = self.enc.read() # For vex disk, each slot = 4 degrees
            if newPos != self.state:
                self.state = newPos

            rospy.logdebug('State: ' + str(self.state))
            self.pub.publish(self.state)
            self.rate.sleep()

if __name__ == "__main__":
    try:
        encode = encoder()
        encode.run()
        rospy.spin()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')

    GPIO.cleanup()