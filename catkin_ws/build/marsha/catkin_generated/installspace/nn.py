
import tensorflow as tf
from tf.keras import layers as tf_layers
from marsha.msg import Float64
from marsha.msg import TrainData
import rospy
import numpy as np

class Network(object):
    def __init__(self):
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], True)
        
        rospy.init_node('Network')
        ns = rospy.get_namespace()

        self.pub = rospy.Publisher(ns + 'nn_out', Float64, queue_size=10)
        # Change this to generalize it
        rospy.Subscriber(ns +  'setpoint', Float64, self.setpointCallBack)
        rospy.Subscriber(ns + 'state', Float64, self.stateCallBack)
        rospy.Subscriber(ns + 'train', TrainData, self.train)
        self.setpoint = 0
        self.state = 0

        input_shape = rospy.get_param('input_shape')
        output_shape = rospy.get_param('output_shape')

        self.model = tf.keras.models.Sequential()
        self.model.add(tf_layers.Dense(units=4, input_shape=input_shape, activation='sigmoid'))
        self.model.add(tf_layers.Dense(units=output_shape, activation='sigmoid'))

    def call(self, input):
        # need to normalize
        out = self.model.predict(input)
        return out

    def run(self):
        while not rospy.is_shutdown():
            input = np.array([self.setpoint, self.state])
            out = self.call(input)
            self.pub.publish(out)
            self.rate.sleep()

    def train(self, train_data):
        self.model.fit([train_data.setpoint, train_data.state], train_data.y, epochs=10)

    def setpointCallBack(self, msg):
        self.setpoint = msg.data

    def stateCallBack(self, msg):
        self.state = msg.data

if __name__ == '__main__':
    try:
        net = Network()
        net.run()
    except Exception as e:
        print(e)
