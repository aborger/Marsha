from numpy.core.fromnumeric import reshape
import tensorflow as tf
import numpy as np

import tqdm
from Environments.environment import Environment
from AI.Agent.nn import Network
import util
from config import train_config as config
import time
from AI.Agent.commPolicy import Comm_Policy
# This is the one that can be customized with a gui
# An agent is the brain of a single arm


class Policy:
    def __init__(self, action_space, observe, reset) -> None:
        physical_devices = tf.config.list_physical_devices('GPU')
        tf.config.experimental.set_memory_growth(physical_devices[0], True)

        self.env = Environment(action_space, observe, reset)
        self.buffer = util.ReplayBuffer(100000)
        self.comm_policy = Comm_Policy()
        self.comm_policy.create_maps()



    def select_epsilon_greedy_action(self, state):
        rand = tf.random.uniform((1,))
        if rand < config.epsilon:
            return self.comm_policy.random_actions()

        else:
            actions = self.comm_policy.execute_policy(state)
            print('Actions: ', actions)
            return actions

    def train(self):
        avg_rewards = []
        best_ep = {
            "reward": 0,
            "model": None,
            "actions": []
        }

        for episode in tqdm.tqdm(range(config.num_episodes)):
        #for episode in Config.num_episodes:
            #print("Training is resetting.")
            state = self.env.reset()
            ep_reward, done = 0, 0
            self.env.current_frame = 0
            while not done:
                #print('Beginning of frame: ', self.env.current_frame)
                action = self.select_epsilon_greedy_action(state)
                next_state, reward, done = self.env.step(action)
                if reward != 0:
                    ep_reward = reward
                #print('Frame recieved reward of: ', ep_reward)
                
                if state is not None:
                    self.buffer.add(state, action, reward, next_state, done)
                else:
                    print("State:")
                    print(state)
                    raise

                state = next_state

                """
                if  self.env.get_frame_num() % config.copy_rate == 0:
                    self.target_nn.set_weights(self.main_nn.get_weights())
                """
                if len(self.buffer) >= config.batch_size:
                    sarsa = self.buffer.sample()

                    self.comm_policy.inner_train(sarsa)


            # If not one of the last episodes lower epsilon
            if episode > config.num_explore and episode < config.num_episodes * config.epsilon_discount:
                config.epsilon -= config.epsilon_discount / config.num_episodes

            # Update last 100 episodes
            if len(avg_rewards) == 10:
                avg_rewards = avg_rewards[1:]

            avg_rewards.append(ep_reward)
            #print(' ep reward:', ep_reward)
            # Update best episode
            if ep_reward > best_ep["reward"]:
                best_ep["reward"] = ep_reward
                best_ep["comm_policy"] = self.comm_policy

            # Print every so often
            if episode % config.print_rate == 0:
                print(f'Episode {episode}/{config.num_episodes}. Epsilon: {config.epsilon:.3f}. \n'
				      f'Last 10 episodes: \n'
				      f'Average Reward: {np.mean(avg_rewards):.3f}\n')

        # Print once training is complete
        print(f'Episode {episode}/{config.num_episodes}. Epsilon: {config.epsilon:.3f}. \n'
				      f'Last 10 episodes: \n'
				      f'Average Reward: {np.mean(avg_rewards):.3f}\n')

        print('Best Reward: ' + str(best_ep["reward"]))
        return best_ep
    