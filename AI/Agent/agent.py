from AI.server import Server
from enum import Enum
import numpy as np
import config.env_config as config
from PIL import Image

class Agent:
    def __init__(self):
        self.server = Server()
        self.input_experts = []     # Camera, IMU, or Lidar
        self.output_experts = []    # One for each joint

    def action(self, action_num):
        act = [0 for i in range(config.NUM_ACTIONS)]
        act[action_num] = 1

        json = {"actions": act}
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
        #print(state)
        #print(state.shape)
        reward = env["contact"]

        return state, reward



    def reset(self):
        json = {"reset": True}
        self.server.write(json)

        state, reward = self.observe()
        return state