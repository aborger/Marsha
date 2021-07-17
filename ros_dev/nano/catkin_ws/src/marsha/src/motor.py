#!/usr/bin/env python

import rospy
from std_msgs.msg import Float64
import RPi.GPIO as GPIO
import time
import os


MOTOR_PMW = 12
MOTOR_DIR = 26

EFFORT_GIVE = 3

class Motor(object):
    def __init__(self):
        rospy.init_node('Motor', log_level=rospy.DEBUG)
        ns = rospy.get_namespace()

        GPIO.setmode(GPIO.BCM)

        GPIO.setup(MOTOR_PMW, GPIO.OUT)
        GPIO.setup(MOTOR_DIR, GPIO.OUT)

        self.effort = 0
        self.nn = 0


        time.sleep(1)
        self.motor = GPIO.PWM(MOTOR_PMW, 100)

        rospy.Subscriber(ns + 'control_effort', Float64, self.controlCallBack)
        rospy.Subscriber(ns + 'nn_out', Float64, self.nnCallBack)
        self.rate = rospy.Rate(10)

    def nnCallBack(self, msg):
        self.nn = msg.data

    def controlCallBack(self, msg):
        power = int(msg.data + self.nn)
        rospy.logdebug('Effort: ' + str(power))
        if power < -1 * EFFORT_GIVE:
            GPIO.output(MOTOR_DIR, GPIO.LOW)
            self.motor.start(power * -1)
        elif power > EFFORT_GIVE:
            GPIO.output(MOTOR_DIR, GPIO.HIGH)
            self.motor.start(power)
        else:
            self.motor.start(0)


if __name__ == "__main__":
    rospy.loginfo('starting...')

    motor = Motor()
    try:
        rospy.spin()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')

    rospy.loginfo('Done')
    motor.motor.start(0)
    GPIO.cleanup()

