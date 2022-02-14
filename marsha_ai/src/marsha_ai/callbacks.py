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
        planning_punishment = self.locals['infos'][0]['plan_results'].planning_punishment
        plan_success = self.locals['infos'][0]['plan_results'].success        


        #info = self.locals['infos'][0]
        #print(self.locals)
        #print("Object position:", self.locals["new_obs"])

        self.logger.record('Reward', reward)
        self.logger.record('Catches', self.num_catches)
        self.logger.record('Planning/Timing_punishment', planning_punishment)
        self.logger.record('Planning/Successful_Plan', plan_success)
        #self.logger.record('Time: ' + info['timing']['func_name'], info['timing']['elapsed_time'])
        #self.logger.record('ADR Difficulty', info['difficulty'])
        return True

