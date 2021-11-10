#!/usr/bin/env python3
from stable_baselines3.common.callbacks import BaseCallback

class TensorboardCallback(BaseCallback):
    def __init__(self, verbose=1):
        super(TensorboardCallback, self).__init__(verbose)

    def _on_step(self) -> bool:
        reward = self.locals['rewards'][0]
        #print("Reward: ", reward)
        self.logger.record('Reward', reward)
        return True

