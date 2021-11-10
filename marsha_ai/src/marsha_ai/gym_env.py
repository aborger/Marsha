#!/usr/bin/env python3
import gym
from gym import spaces
import numpy as np
import rospy

from marsha_ai.util import func_timer



MAX_REWARD = 100

class MarshaGym(gym.Env):

    def __init__(self, ros_interface):
        super(MarshaGym, self).__init__()
        self.ros_interface = ros_interface
        self.reward_range = (0, MAX_REWARD)
        self.current_step = 0

        # As stated in catch_interface.py CatchInterface.perform_action
        # Current actions has shape (8)
        # where action[0,1] corresponds to a step in the x axis
        # action[2,3] corresponds to a step in the y axis
        # action[4,5] corresponds to a step in the z axis
        # action[6] closes the gripper
        # action[7] opens the gripper
        self.action_space = spaces.Discrete(8)

        # Current observations: position of cuboid relative to link_6
        self.observation_space = spaces.Box(-1, 1, shape=(3,), dtype=np.float32)

        self.episode_length = rospy.get_param('/hyperparameters/episode_length')


    def step(self, action):
        done, reward = self.ros_interface.perform_action(action)
        self.current_step += 1
        obs = self.ros_interface.observe()
        if self.current_step > self.episode_length:
            done = True
            self.ros_interface.log_progress()


        return obs, reward, done, {}

    def reset(self):
        self.ros_interface.reset_simulation()
        self.current_step = 0

        observation = self.ros_interface.observe()
        #print(observation)
        #print(observation.shape)
        return observation

    def render(self, mode='', close=False):
        print('rendering... (Note: This is not necessary)')
        
    