import rospy
from std_msgs.msg import Float64
from std_msgs.msg import Bool
from random import randint

MOVEMENT_RANGE = 180

class Rand(object):
    def __init__(self):
        rospy.init_node('Rand', log_level=rospy.DEBUG)
        rospy.loginfo('Starting...')
        ns = rospy.get_namespace()

        self.pub_sp = rospy.Publisher(ns + 'setpoint', Float64, queue_size=10)
        rospy.Subscriber(ns + 'episode_status', Bool, self.statusCallBack)

        self.rate = rospy.Rate(50)
        self.setpoint = 0

    def statusCallBack(self, msg):
        self.setpoint = randint(-1 * MOVEMENT_RANGE, MOVEMENT_RANGE)

    def run(self):
        while not rospy.is_shutdown():
            rospy.logdebug('Setpoint: ' + str(self.setpoint))
            self.pub_sp.publish(self.setpoint)
            self.rate.sleep()


if __name__ == "__main__":
    try:
        r = Rand()
        r.run()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')