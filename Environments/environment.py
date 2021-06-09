from config import train_config as config
from numpy import random

class Environment:
    # Parameters passed in:
    # action_space: list of functions that will be called to perform action
    # observe: function to be called that will observe the environment
    # reset: function to be called that will reset the environment

    def __init__(self, action_space, observe, reset):
        self.action_space = action_space
        self.observe_func = observe
        self.reset_func = reset
        self.current_frame = 0

    def reset(self):
        initial_observation = self.reset_func()
        self.current_frame = 0
        return initial_observation

    def step(self, action):
        self.action_space(action)
        state, reward = self.observe_func()


        if reward > config.goal_reward:
            print("=============== Finished ====================")
            reward = 1
            done = 1
        else:
            reward = reward/(config.goal_reward) # last time it worked this was * 2
            done = 0

        self.current_frame += 1
        
        return state, reward, done

    def get_frame_num(self):
        return self.current_frame
        

    def random_action(self):
        return random.randint(0, config.NUM_ACTIONS)