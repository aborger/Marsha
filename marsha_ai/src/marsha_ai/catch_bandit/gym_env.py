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

from time import sleep

from marsha_ai import catch_bandit

MAX_REWARD = 100
MAX_EPISODE_LENGTH = 5

class MarshaGym(gym.Env):
    def __init__(self, ros_interface):
        super(MarshaGym, self).__init__()
        self.ros_interface = ros_interface
        self.reward_range = (0, 100)
        self.current_step = 0
        self.episode_num = 0


        self.action_space = catch_bandit.action_space

        self.observation_space = catch_bandit.observation_space  



    def step(self, action):
        reward, move_success, info = self.ros_interface.perform_action(action)
        observation = self.ros_interface.perform_observation()

        self.current_step += 1

        # TODO: make done when ball is above distance away from arm or max episode (a lot higher)
        if self.current_step > MAX_EPISODE_LENGTH:
            done = True
        else:
            done = move_success

        # observation, reward, done, info
        return observation, reward, done, info

    def reset(self):
        self.ros_interface.reset_simulation()
        self.current_step = 0
        print("Finished episode ", self.episode_num)
        self.episode_num += 1
        #sleep(1) # Waits for trajectory prediction to calculate velocity, could be less
        observation = self.ros_interface.perform_observation()

        return observation


    def render(self, mode='', close=False):
        pass

        
