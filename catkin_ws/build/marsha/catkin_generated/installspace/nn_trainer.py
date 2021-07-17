
import rospy
from std_msgs.msg import Float64
from marsha.msg import TrainData
from marsha.msg import Floats
import subprocess
import numpy as np

# These constants will be changed to parameters
NUM_SAMPLES = 20 # Per episode (episode is time setpoint is set to settle time), this doesn't need to be constant

def displace(list, value):
    list.pop(0)
    list.append(value)
    return list

class NN_Trainer(object):
    def __init__(self):
        rospy.init_node('Trainer')
        rospy.loginfo('Starting...')
        ns = rospy.get_namespace()

        num_episodes = rospy.get_param("/num_episodes")

        rospy.logdebug('startin nn...')
        self.nn_proc = subprocess.Popen(['C:\\Users\\borge\\MARSHA\\ros_dev\\pc\\catkin_ws\\src\\marsha\\src\\run_nn.bat', str(num_episodes)], stdout=subprocess.PIPE)

        rospy.logdebug('nn started')
        self.pub = rospy.Publisher(ns + 'train', TrainData, queue_size=10)
        rospy.Subscriber(ns + 'setpoint', Float64, self.setpointCallBack)

        # This section could really be done in nn.py
        rospy.Subscriber(ns + 'control_effort', Float64, self.pidCallBack)
        rospy.Subscriber(ns + 'nn_out', Float64, self.nnCallBack)


        self.rate = rospy.Rate(.5)

        # make sure these two have the same rate
        self.pid = [0.0] * NUM_SAMPLES # no, need to append
        self.nn = [0.0] * NUM_SAMPLES # no, need to append
        self.setpoint = 0

        self.max_error = -1
        self.min_error = 99999

        self.num_iterations = 0


    def pidCallBack(self, msg):
        self.pid = displace(self.pid, msg.data)

    def nnCallBack(self, msg):
        self.nn = displace(self.nn, msg.data)

    def setpointCallBack(self, msg):
        self.num_iterations += 1 # currently only going on first iteration

 

    def run(self):
        while not rospy.is_shutdown():
            #rospy.loginfo('Num iterations: ' + str(self.num_iterations))
            #if self.num_iterations >= 10:
            # Calculate reward/targets, the sample that produced smallest error recieves target of 1
            # sample with greatest error recieves 0, other samples recieve targets accordingly
            errors = np.array([abs(pid - nn) for pid, nn in zip(self.pid, self.nn)])
            rospy.logdebug('errors: ' + str(errors))
            if min(errors) < self.min_error:
                self.min_error = min(errors)
            if max(errors) > self.max_error:
                self.max_error = max(errors)
                
            targets = (errors - self.min_error) * (2) / (self.max_error - self.min_error) - 1
            targets = -1 * targets
            rospy.logdebug('targets: ' + str(targets))
            self.pub.publish(targets = targets)
            self.num_iterations = 0 # currently only going on first iteration
            self.rate.sleep()



if __name__ == "__main__":

    try:
        trainer = NN_Trainer()
        trainer.run()
    except KeyboardInterrupt:
        rospy.loginfo('Exiting...')

        