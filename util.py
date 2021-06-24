from collections import deque
from threading import Thread
import threading
import numpy as np
from config import train_config as config
from config import env_config
import tensorflow as tf
from tensorflow.python.keras.backend import softmax
from tensorflow.python.keras.backend import argmax


class ReplayBuffer(object):
    def __init__(self, size):
        self.buffer = deque(maxlen = size)
        
    def add(self, state, action, reward, next_state, done):
        self.buffer.append((state, action, reward, next_state, done))
        
    def __len__(self):
        return len(self.buffer)
        
    def sample(self):
        states, actions, rewards, next_states, dones = [], [], [], [], []
        idx = np.random.choice(len(self.buffer))

        elem = self.buffer[idx]
        state, action, reward, next_state, done = elem
        sarsa = (state, action , reward, next_state, done)
        return sarsa

# This is the equivalent function of Arduino's map() function
def map(x, in_min, in_max, out_min, out_max):
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

def select_action(network_output):
    best_actions = argmax(network_output, axis=1).numpy()
    best_action = best_actions[0]
    
    #action_probs = softmax(network_output, axis=1).numpy()
    #probs = np.reshape(action_probs, newshape=(env_config.NUM_ACTIONS))
    #best_action = np.random.choice(a=env_config.NUM_ACTIONS, p=probs)
    #print(best_action)
    return best_action

def start_threads(threads):
    if not all(isinstance(x, threading.Thread) for x in threads):
        raise TypeError("thread list must be type 'Thread'")
    for thread in threads:
        thread.start()

def join_threads(threads):
    if not all(isinstance(x, threading.Thread) for x in threads):
        raise TypeError("thread list must be type 'Thread'")
    for thread in threads:
        thread.join()

def exists(cls, value):
    if value is None:
        raise ValueError(type(cls), ' has an empty value.')

