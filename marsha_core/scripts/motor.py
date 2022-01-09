#!/usr/bin/env python

import rospy
from std_msgs.msg import Float64
from std_msgs.msg import Bool
import RPi.GPIO as GPIO
import time
import os


MOTOR_PMW = 12
MOTOR_DIR = 26

EFFORT_GIVE = 3
DEFAULT_POWER = 50

class Motor(object):
    def __init__(self):
        rospy.init_node('Motor', log_level=rospy.DEBUG)
        ns = rospy.get_namespace()

        GPIO.setmode(GPIO.BCM)

        GPIO.setup(MOTOR_PMW, GPIO.OUT)
        GPIO.setup(MOTOR_DIR, GPIO.OUT)

        self.effort = 0
        self.grasp_time = 0
        self.grasp_time_left = 0


        time.sleep(1)
        self.motor = GPIO.PWM(MOTOR_PMW, 100)

        rospy.Subscriber('control_effort', Float64, self.controlCallBack)
        rospy.Subscriber('grab', Bool, self.grabCallBack)
        self.rate = rospy.Rate(10)

    def grabCallBack(self, msg):
        if msg.data:
            self.grasp_time_left = rospy.get_param('/gripper/grasp_drive_time')
        else:
            self.grasp_time_left = 0

    def run(self):
        while not rospy.is_shutdown():
            print("grasp_time:", self.grasp_time, " time_left: ", self.grasp_time_left)
            if self.grasp_time < self.grasp_time_left - 0.05:
                GPIO.output(MOTOR_DIR, GPIO.HIGH)
                self.motor.start(50)
                self.grasp_time += 0.1
            elif self.grasp_time > self.grasp_time_left + 0.05:
                GPIO.output(MOTOR_DIR, GPIO.LOW)
                self.motor.start(50)
                self.grasp_time -= 0.1
            else:
                self.motor.start(0)
            self.rate.sleep()


    def move(self, power):
        rospy.logdebug('Effort: ' + str(power))
        if power < -1 * EFFORT_GIVE:
            GPIO.output(MOTOR_DIR, GPIO.LOW)
            self.motor.start(power * -1)
        elif power > EFFORT_GIVE:
            GPIO.output(MOTOR_DIR, GPIO.HIGH)
            self.motor.start(power)
        else:
            self.motor.start(0)

    def controlCallBack(self, msg):
        power = int(msg.data)
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
        motor.run()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')

    rospy.loginfo('Done')
    motor.motor.start(0)
    GPIO.cleanup()

