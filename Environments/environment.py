from config import train_config as config
from config import env_config
from numpy import random

class Environment:
    # Parameters passed in:
    # action_space: list of functions that will be called to perform action
    # observe: function to be called that will observe the environment
    # reset: function to be called that will reset the environment

    def __init__(self, perform_actions, observe, reset):
        self.perform_actions = perform_actions
        self.observe_func = observe
        self.reset_func = reset
        self.current_frame = 0

    def reset(self):
        initial_observation = self.reset_func()
        self.current_frame = 0
        return initial_observation

    def step(self, actions):
        self.perform_actions(actions)
        state, reward = self.observe_func()

        done = 0
        if reward > config.goal_reward:
            print("=============== Finished ====================")
            reward = 1000
 
        if self.current_frame > config.max_frames:
            done = 1
        

        self.current_frame += 1
        return state, reward, done

    def get_frame_num(self):
        return self.current_frame
        