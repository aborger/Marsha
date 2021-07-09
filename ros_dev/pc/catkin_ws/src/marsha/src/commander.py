import rospy
from std_msgs.msg import Float64

def Commander():
    ns = rospy.get_namespace()
    pub = rospy.Publisher(ns + 'setpoint', Float64, queue_size=10)
    rospy.init_node('Commander', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        var = float(input())
        rospy.loginfo(var)
        pub.publish(var)
        rate.sleep()

if __name__ == '__main__':
    try:
        Commander()
    except rospy.ROSInterruptException:
        pass
