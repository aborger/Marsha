# This is where the connections between each expert is stored

import numpy as np
from numpy.core.fromnumeric import shape
import tensorflow as tf
from tensorflow.python.eager.context import PhysicalDevice
from config import train_config as config
from config import env_config
import time
import util

class Network(tf.keras.Model):

    def __init__(self):
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], True)

        super(Network, self).__init__()
        self.dense1 = tf.keras.layers.Dense(units=4,
                                            input_shape=(1, 4), activation='sigmoid', kernel_initializer='RandomUniform')
        self.dense2 = tf.keras.layers.Dense(units=4, activation='sigmoid', kernel_initializer='RandomUniform')
        self.dense3 = tf.keras.layers.Dense(units=15, activation='relu')
        self.dense4 = tf.keras.layers.Dense(units=20, activation='relu')
        self.dense5 = tf.keras.layers.Dense(units=config.NUM_ACTIONS, activation='softmax', kernel_initializer='RandomUniform')

    def call(self, input):
        #print('input:', input)
        # normalize
        #print('input: ', input)
        scaledInput = util.map(input, 0, env_config.ENV_HEIGHT, 0, 1)

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
        if DEBUG: print('Reward:', reward)
        if DEBUG: print('Done:', done)
        next_qs = target_nn(next_state)
        if DEBUG: print('next_qs:', next_qs)
        max_next_qs = tf.reduce_max(next_qs, axis=1)
        if DEBUG: print('max next qs:', max_next_qs)
        
        target = reward + config.discount_factor * max_next_qs
        target = target * (1 - done) - done
        if DEBUG: print('target:', target)
        with tf.GradientTape() as tape:
            qs = self.call(state)
            if DEBUG: print('qs:',qs)
            action_mask = tf.one_hot(action, config.NUM_ACTIONS)
            masked_qs = tf.reduce_sum(tf.multiply(qs, action_mask), axis=1)
            if DEBUG: print('masked_qs:',masked_qs)
            loss = config.mse(target, masked_qs)
            if DEBUG: print('loss:', loss)
        grads = tape.gradient(loss, self.trainable_variables)
        config.optimizer.apply_gradients(zip(grads, self.trainable_variables))
        if DEBUG: time.sleep(5)
        return loss