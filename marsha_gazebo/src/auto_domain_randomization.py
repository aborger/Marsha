#!/usr/bin/env python
# This file is called by "reset" to increase or decrese the difficulty of the task based on how good the previous episode's reward was
import numpy as np

class DRandomizer:
    def __init__(self, shape, range):
        self.shape = shape
        self.prev_reward = 0
        self.range = range

    def get_domain(reward):
        reward_gain = (reward - self.prev_reward) / self.prev_reward
        return np.random.rand(self.shape)
    