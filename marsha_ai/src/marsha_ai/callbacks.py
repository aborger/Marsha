#!/usr/bin/env python3
from stable_baselines3.common.callbacks import BaseCallback

class TensorboardCallback(BaseCallback):
    def __init__(self, verbose=1):
        super(TensorboardCallback, self).__init__(verbose)
        self.num_catches = 0

    def _on_step(self) -> bool:
        #print(self.locals)
        reward = self.locals['reward'][0]
        if self.locals['infos'][0]['catch_success']:
            self.num_catches += 1
        plan_results = self.locals['infos'][0]['plan_results']        


        #info = self.locals['infos'][0]
        #print(self.locals)
        #print("Object position:", self.locals["new_obs"])

        self.logger.record('Reward', reward)
        self.logger.record('Catches', self.num_catches)
        self.logger.record('Planning/Pre_grasp_planning', plan_results.pre_grasp_success)
        self.logger.record('Planning/Grasp_planning', plan_results.grasp_success)

        #self.logger.record('Time: ' + info['timing']['func_name'], info['timing']['elapsed_time'])
        #self.logger.record('ADR Difficulty', info['difficulty'])
        return True

