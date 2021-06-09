# This is where the connections between each expert is stored

import numpy as np
from numpy.core.fromnumeric import shape
import tensorflow as tf
from tensorflow.python.eager.context import PhysicalDevice
from config import train_config as config
import time

class Network(tf.keras.Model):

    def __init__(self):
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], True)

        super(Network, self).__init__()
        self.dense1 = tf.keras.layers.Dense(units=4,
                                            input_shape=(1, 4), activation='relu')
        self.dense2 = tf.keras.layers.Dense(units=15, activation='relu')
        self.dense3 = tf.keras.layers.Dense(units=15, activation='relu')
        self.dense4 = tf.keras.layers.Dense(units=20, activation='relu')
        self.dense5 = tf.keras.layers.Dense(units=config.NUM_ACTIONS, activation='sigmoid')

    def call(self, input):
        #print('input:', input)
        # normalize
        #print('input: ', input)
        scaledInput = np.empty(shape=(1, 2))
        scaledInput[0, 0] = (input[0,0] - 300) / (500 - 300)
        scaledInput[0, 1] = (input[0,1] - 300) / (500 - 300)
        #print('scaled:', scaledInput)
        #print('scaled input:', scaledInput)
        #print('scaledInput:', scaledInput)
        x = self.dense1(scaledInput)
        #print('dense1:', x)
        x = self.dense2(x)
        #x = self.dense3(x)
        #x = self.dense4(x)
        x = self.dense5(x)
        #print('out:', x)
        #time.sleep(1)
        return x

    def train(self, target_nn, state, action, reward, next_state, done):
        DEBUG = False
        if DEBUG: print('-------------')
        next_qs = target_nn(next_state)
        if DEBUG: print('next_qs:', next_qs)
        max_next_qs = tf.reduce_max(next_qs, axis=0)
        if DEBUG: print('max next qs:', max_next_qs)
        target = reward + (done) * config.discount_factor * max_next_qs
        if DEBUG: print('target:', target)
        with tf.GradientTape() as tape:
            qs = self.call(state)
            if DEBUG: print('qs:',qs)
            # Create one hot
            action_mask = tf.zeros([config.NUM_ACTIONS]).numpy()

            action_mask[action] = 1
            if DEBUG: print('action mask:', action_mask)
            masked_qs = tf.reduce_sum(action_mask * qs, axis=0)
            if DEBUG: print('masked qs:', masked_qs)
            loss = config.mse(target, masked_qs)
            if DEBUG: print('loss:', loss)
        grads = tape.gradient(loss, self.trainable_variables)
        config.optimizer.apply_gradients(zip(grads, self.trainable_variables))
        #time.sleep(5)
        return loss