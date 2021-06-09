from collections import deque
from numpy import random

class ReplayBuffer(object):
    def __init__(self, size):
        self.buffer = deque(maxlen = size)
        
    def add(self, state, action, reward, next_state, done):
        self.buffer.append((state, action, reward, next_state, done))
        
    def __len__(self):
        return len(self.buffer)
        
    def sample(self):
        states, actions, rewards, next_states, dones = [], [], [], [], []
        idx = random.choice(len(self.buffer))

        elem = self.buffer[idx]
        state, action, reward, next_state, done = elem

        return state, action, reward, next_state, done