#!/usr/bin/env python3

# The code for AI method 3. A bandit problem with a continuous action space
# where the action is a tupe with continuous values (latent grasp, catch time/position)
# calculated deterministicly

# The latent grasp is a value or set of values that will generate a grasp deterministicly in the object space.

# The catch time is the time slice of the catch, the time slice will then be used to 
# determine the position of the object at that time

# The observation space is also continuous:
# (3D object position, 3D linear velocity)

# Recurrent policy will not work with the DDPG algorithm.

import gym
from gym import spaces
import numpy as np
import rospy
import math

MAX_REWARD = 100

class MarshaGym(gym.Env):
    def __init__(self, ros_interface):
        super(MarshaGym, self).__init__()
        self.ros_interface = ros_interface
        self.reward_range = (0, 100)
        self.current_step = 0

        # action_space: (r, theta, phi, time)
        # r, theta, and phi represent polar coordinates of a grasp
        # time represents the time slice along the objects trajectory
        # Could also include grasp close speed & threshold
        action_space_min = np.array([0, 0, 0, 0]) 
        action_space_max = np.array([1, math.pi, 2*math.pi, 1])
        self.action_space = spaces.Box(action_space_min, action_space_max)  

        # Observation space: (Object position, Object velocity)
        self.observation_space = spaces.Box(low=-1, high=1, shape=(2, 3))

    def step(self, action):
        pass

if __name__ == "__main__":
    print(arr)