#!/usr/bin/env python3
import gym
from gym import spaces
import numpy as np
import rospy

from marsha_ai.util import func_timer
from marsha_msgs.msg import Timer
from rospy_message_converter import message_converter

msg_to_dict = message_converter.convert_ros_message_to_dictionary

import time



MAX_REWARD = 100

class MarshaGym(gym.Env):

    def __init__(self, ros_interface):
        super(MarshaGym, self).__init__()
        self.ros_interface = ros_interface
        self.reward_range = (0, MAX_REWARD)
        self.current_step = 0

        self.info = {"action_time": 0, "observe_time": 0}

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

        self.timing = {}

        rospy.Subscriber("/func_timer", Timer, self.time_callback)

    def time_callback(self, data):
        data_dict = msg_to_dict(data)

        self.timing.update(data_dict)


    def step(self, action):
        done, reward = self.ros_interface.perform_action(action)
        self.current_step += 1
        obs = self.ros_interface.observe()
        if self.current_step > self.episode_length:
            done = True
        
        info = self.timing

        return obs, reward, done, info

    def reset(self):
        self.ros_interface.reset_simulation()
        self.current_step = 0

        observation = self.ros_interface.observe()
        #print(observation)
        #print(observation.shape)
        return observation

    def render(self, mode='', close=False):
        print('rendering... (Note: This is not necessary)')
        
    