#!/usr/bin/env python3
import gym
from gym import spaces
import numpy as np


MAX_REWARD = 100

class MarshaGym(gym.Env):

    def __init__(self, ros_interface):
        super(MarshaGym, self).__init__()
        self.ros_interface = ros_interface
        self.reward_range = (0, MAX_REWARD)
        self.current_step = 0

        # Current actions has shape (3)
        # where action[0] corresponds to the x axis
        # action[1] corresponds to y axis
        # action[2] corresponds to z axis
        # The value of action element corresponds to the percent of a step to move
        self.action_space = spaces.Box(
            low=0.8, high=1.2, shape=(4,), dtype=np.float16
        )

        # Current observations: desired position(x, y, z)
        self.observation_space = spaces.Box(
            low=0, high=1, shape=(3, 1), dtype=np.float16)


    def step(self, action):
        done, reward = self.ros_interface.perform_action(action)
        self.current_step += 1
        obs = self.ros_interface.observe()
        if self.current_step > 10:
            done = True


        return obs, reward, done, {}

    def reset(self):
        self.ros_interface.reset_simulation()
        self.current_step = 0
        return self.ros_interface.observe()

    def render(self, mode='', close=False):
        print('rendering... (Note: This is not necessary)')
        
    