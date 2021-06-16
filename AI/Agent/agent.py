# This class is specifically how the agent interacts with the environment

from AI.server import Server
from enum import Enum
import numpy as np
import config.env_config as config
from PIL import Image


class Agent:
    def __init__(self):
        self.server = Server()

    def perform_actions(self, actions):
        json = {"actions": actions.tolist()}
        self.server.write(json)


    def observe(self):
        while True:
            try:
                env = self.server.read()
            except:
                continue
            else:
                break
        #state = np.array(env["positions"])
        #state = np.reshape(state, newshape=config.input_shape)
        state = np.asarray(Image.open("../Unity/Rocksat/IMGS/img.jpg"))
        state = np.expand_dims(state, axis=0)
        state = state.astype(int)
        #print(state)
        #print(state.shape)
        reward = env["contact"]

        return state, reward



    def reset(self):
        json = {"reset": True}
        self.server.write(json)

        state, reward = self.observe()
        return state