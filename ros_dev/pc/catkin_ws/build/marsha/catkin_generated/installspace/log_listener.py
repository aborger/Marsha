import rospy
from marsha.msg import log

def logCallBack(msg):
    if msg.loglevel is 0:
        rospy.logdebug(msg.msg.data)
    elif msg.loglevel is 1:
        rospy.loginfo(msg.msg.data)
    elif msg.loglevel is 2:
        rospy.logwarn(msg.msg.data)
    elif msg.loglevel is 3:
        rospy.logerr(msg.msg.data)
    elif msg.loglevel is 4:
        rospy.logfatal(msg.msg.data)

def listener():
    rospy.init_node('Log_listener')
    rospy.Subscriber('bridgeLog', log, logCallBack)

    rospy.spin()

if __name__ == "__main__":
    listener()

