#!/usr/bin/env python3
from stable_baselines3.common.callbacks import BaseCallback

class TensorboardCallback(BaseCallback):
    def __init__(self, verbose=1):
        super(TensorboardCallback, self).__init__(verbose)

    def _on_step(self) -> bool:
        reward = self.locals['rewards'][0]

        info = self.locals['infos'][0]
        #print(self.locals)
        #print("Object position:", self.locals["new_obs"])

        self.logger.record('Reward', reward)
        self.logger.record('Time: ' + info['timing']['func_name'], info['timing']['elapsed_time'])
        self.logger.record('ADR Difficulty', info['difficulty'])
        return True

