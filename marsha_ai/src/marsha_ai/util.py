import rospy
import time
from std_msgs.msg import String

# Times how long to run a function and publishes to ros
def func_timer(func):
    time_pub = rospy.Publisher('/func_timer', String, queue_size=10)
    print('Timing function...')
    
    def inner(*args, **kwargs):
        begin = time.time()
        output = func(*args, **kwargs)
        end = time.time()

        elapsed = end - begin
        time_pub.publish(func.__name__ + ": " + str(elapsed))

        return output

    return inner

