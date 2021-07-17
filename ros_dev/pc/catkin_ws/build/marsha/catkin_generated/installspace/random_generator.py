import rospy
from std_msgs.msg import Float64
from random import randint

RATE = 0.5
CALLS = 10
class Rand(object):
    def __init__(self):
        rospy.init_node('Rand')
        rospy.loginfo('Starting...')
        ns = rospy.get_namespace()

        self.pub_sp = rospy.Publisher(ns + 'setpoint', Float64, queue_size=10)
        self.rate = rospy.Rate(RATE * CALLS)
        self.call_num = 0
        self.setpoint = 0

    def run(self):
        while not rospy.is_shutdown():
            if self.call_num is CALLS:
                self.setpoint = randint(-360, 360)
                self.call_num = 0
            else:
                self.call_num += 1
            rospy.logdebug('Setpoint: ' + str(self.setpoint))
            self.pub_sp.publish(self.setpoint)
            self.rate.sleep()


if __name__ == "__main__":
    try:
        r = Rand()
        r.run()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')