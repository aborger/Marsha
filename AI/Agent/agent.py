from AI.server import Server
from enum import Enum
import numpy as np

DISTANCE = 2
class Action(Enum):
    xUp = 0
    xDown = 1
    yUp = 2
    yDown = 3
    none = 4

class Agent:
    def __init__(self):
        self.server = Server()

    def action(self, action_num):
        act = None
        if action_num == 0:
            act = {"x": 1*DISTANCE, "y": 0}
        if action_num == 1:
            act = {"x": -1*DISTANCE, "y": 0}
        if action_num == 2:
            act = {"x": 0, "y": 1*DISTANCE}
        if action_num == 3:
            act = {"x": 0, "y": -1*DISTANCE}
        if action_num == 4:
            act = {"x": 0, "y": 0}
        self.server.write(act)


    def observe(self):
        while True:
            try:
                env = self.server.read()
                targX = env["targX"]
                targY = env["targY"]
                playX = env["playX"]
                playY = env["playY"]
                reward = env["reward"]
            except:
                continue
            else:
                break
        state = np.empty(shape=(1, 4))
        state[0, 0] = targX
        state[0, 1] = targY
        state[0, 2] = playX
        state[0, 3] = playY
        return state, reward



    def reset(self):
        act = {"reset": True}
        self.server.write(act)

        state, reward = self.observe()
        return state