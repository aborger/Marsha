import threading
import tensorflow as tf
from tensorflow._api.v2 import config
from config import train_config

class Expert():
    def __init__(self, input_shape, output_shape) -> None:
        threading.Thread.__init__(self)
        self.id = None
        self.input_shape = None
        self.output_shape = None

        self.memory = None
        self.state = None
        
        self.input = None
        self.output = None
        self.output_ready = None


    def get_output(self):
        self.calculate()
        return self.output

    def calculate(self):
        output = None
        self.output = output

    def set_input(self, input):
        self.input = input

class Neural_Expert(Expert, tf.keras.Model):
    def __init__(self, input_shape, output_shape) -> None:
        Expert().__init__(input_shape, output_shape)
        tf.keras.Model(Neural_Expert, self).__init__()

        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], True)

    def call(self, input):
        x = input
        for layer in self.layers:
            x = self.layer(x)
        return x


    def train(self, target_nn, state, action, reward, next_state, done):
        next_qs = target_nn(next_state)
        max_next_qs = tf.reduce_max(next_qs, axis=1)

        target = reward + config.discount_factor * max_next_qs
        target = target * (1 - done) - done
        
        with tf.GradientTape() as tape:
            qs = self.call(state)
            action_mask = tf.one_hot(action, self.output_shape)
            masked_qs = tf.reduce_sum(tf.multiply(qs, action_mask), axis=1)

            loss = config.mse(target, masked_qs)

        grads = tape.gradient(loss, self.trainable_variables)
        config.optimizer.apply_gradient(zip(grads, self.trainable_variables))


        
