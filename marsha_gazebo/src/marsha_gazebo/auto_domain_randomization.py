#!/usr/bin/env python
# This file is called by "reset" to increase or decrese the difficulty of the task based on how good the previous episode's reward was
import numpy as np

class DRandomizer:
    def __init__(self, shape, range):
        self.shape = shape
        self.prev_reward = 0
        self.range = np.array(range)
        self.difficulty = 0.1

    def get_domain(self, reward):
        reward_gain = 0
        if self.prev_reward != 0:
            reward_gain = (reward - self.prev_reward) / self.prev_reward
        self.prev_reward = reward

        self.difficulty += reward_gain
        print('reward:', reward, 'Prev_reward', self.prev_reward, 'reward_gain:', reward_gain)
        print('Difficulty:', self.difficulty)
        dar = self.range * self.difficulty # Difficulty Adjusted Range
        print('Diff Range:', dar)
        domain = (dar[1] - dar[0]) * np.random.random_sample(self.shape) + dar[0]
        return domain, dar
    