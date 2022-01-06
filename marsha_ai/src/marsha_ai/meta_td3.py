#!/usr/bin/env python3

"""

* Meta TD3 Algorithm

* Combines iMAML and TD3 algorithms to learn initial parameters to be fed into the stable-baselines3 (SB3) TD3 algorithm.

* Initial/Meta parameters are learned by approximating the jacobian-vector product (I+1/lambda*H) with the conjugate gradient.

* Note: SB3 uses pyTorch for their TD3 algorithm, however at the time of writing this I was not proficient in pyTorch so I used tensorflow instead.
        Therefore, after each meta episode I had to convert the parameters between pyTorch and Tensorflow. This could by avoided by using pyTorch throughout.

* Author: Aaron Borger <aborger@nnu.edu (307)534-6265>


"""



import gym
from stable_baselines3 import TD3
from stable_baselines3.common.callbacks import EvalCallback
from stable_baselines3.common.callbacks import StopTrainingOnMaxEpisodes
from stable_baselines3.common.buffers import ReplayBuffer
from stable_baselines3.common.monitor import Monitor

from marsha_ai import catch_bandit as TaskEnv
from marsha_ai.catch_bandit.gym_env import MarshaGym
from marsha_ai.catch_bandit.catch_interface import CatchInterface
from marsha_ai.callbacks import TensorboardCallback

import torch
import tensorflow as tf
import numpy as np
from copy import deepcopy

# debug
from stable_baselines3.common.preprocessing import get_action_dim, get_flattened_obs_dim

gi_APPROXIMATION_THRESHOLD = 1e-10

MSE = tf.keras.losses.MeanSquaredError()
OPTIMIZER = tf.keras.optimizers.Adam(learning_rate=0.1)

ACTOR_LOSS = 0
CRITIC_LOSS = 1

META_BATCH_SIZE = 2
META_GRADIENT_STEPS = 2

class Observation: # Unit Test
    def __init__(self, num_batches, observation_len, action_len):
        self.observations = tf.constant(np.random.rand(num_batches, observation_len).astype('f'))
        self.next_observations = tf.constant(np.random.rand(num_batches, observation_len).astype('f'))
        self.actions = tf.constant(np.random.rand(num_batches, action_len).astype('f'))
        self.rewards = tf.constant(np.random.rand(num_batches, 1).astype('f'))
        self.dones = tf.constant(np.zeros(shape=(num_batches, 1)).astype('f'))


class Replay_Buffer: # Unit Test
    def __init__(self, observation_len, num_batches):
        np.random.rand(num_batches, observation_len)
        self.testing_data = Observation(num_batches, observation_len, observation_len)
        self.training_data = Observation(num_batches, observation_len, observation_len)


class Task:
    def __init__(self, env):
        batch_size = 2 # number of steps in reinforcement learning
        #self.replay_buffer = Replay_Buffer(get_flattened_obs_dim(TaskEnv.observation_space), batch_size)

        self.env = env

    def learn(self, initial_models):
        mesa_algo = TD3("MlpPolicy", self.env, verbose=1, learning_starts=1) # Note: Unecessarily initializes parameters (could speed up a bit by fixing)'

        mesa_algo.set_parameters(to_torch(initial_models), exact_match=False)
        LOG_DIR = "/home/jet/catkin_ws/src/marsha/marsha_ai/training/logs/"
        MODEL_DIR = "/home/jet/catkin_ws/src/marsha/marsha_ai/training/models/"

        callback_list = []
        callback_list.append(TensorboardCallback())
        callback_list.append(StopTrainingOnMaxEpisodes(max_episodes=5, verbose=1))
        """callback_list.append(EvalCallback(self.env, best_model_save_path=MODEL_DIR, log_path=LOG_DIR,
                                    deterministic=True,
                                    eval_freq=5,
                                    n_eval_episodes=1))"""
        mesa_algo.learn(total_timesteps=1000, callback=callback_list)       #rospy.get_param("/hyperparameters/total_timesteps")

        print("finished training! Testing mesa network...")
        test_buffer = ReplayBuffer(100, TaskEnv.observation_space, TaskEnv.action_space, device="cuda")

        test_env = Monitor(self.env)
        done = False
        ob = test_env.reset()
        while not done:
            action, state = mesa_algo.predict(ob)
            next_ob, reward, done, info = test_env.step(action)
            test_buffer.add(ob, next_ob, action, reward, done, [info])
            ob = next_ob


        meta_buffer = {"test": test_buffer, "train": mesa_algo.replay_buffer}

        optimized_mesa_parameters = mesa_algo.get_parameters()
        tf_mesa_models = from_torch(optimized_mesa_parameters)
        
        return meta_buffer, tf_mesa_models

class Actor(tf.keras.Model):
    def __init__(self):
        super().__init__()
        
        self._initialize()

        self.call(tf.constant(np.zeros(shape=(1, get_flattened_obs_dim(TaskEnv.observation_space))))) # Initialize parameters by calling

        self.loss_function_id = ACTOR_LOSS


    def _initialize(self):
        self.dense1 = tf.keras.layers.Dense(400, input_shape=(get_flattened_obs_dim(TaskEnv.observation_space),), activation='relu')
        self.dense2 = tf.keras.layers.Dense(300, activation='relu')
        self.dense3 = tf.keras.layers.Dense(get_action_dim(TaskEnv.action_space), activation='tanh')

    def call(self, inputs):
        x = self.dense1(inputs)
        x = self.dense2(x)
        x = self.dense3(x)
        return x

class Critic(tf.keras.Model):
    def __init__(self):
        super().__init__()
        self._initialize()

        # Initialize parameters by calling
        self.call(
            tf.constant(np.zeros(shape=(1, get_flattened_obs_dim(TaskEnv.observation_space)))),
            tf.constant(np.zeros(shape=(1, get_action_dim(TaskEnv.action_space))))
            ) 
        self.loss_function_id = CRITIC_LOSS

    def _initialize(self):
        self.dense1 = tf.keras.layers.Dense(400, input_shape=(get_flattened_obs_dim(TaskEnv.observation_space) + get_action_dim(TaskEnv.action_space),), activation='relu')
        self.dense2 = tf.keras.layers.Dense(300, activation='relu')
        self.dense3 = tf.keras.layers.Dense(1)

    def call(self, observations, actions):
        inputs = tf.concat([observations, actions], axis=1)
        x = self.dense1(inputs)
        x = self.dense2(x)
        x = self.dense3(x)
        return x

# Convert from torch should be used to convert optimized mesa parameters from sb3 to train the meta parameters
def from_torch(torch_models):
    actor = ["actor.mu.0.weight","actor.mu.0.bias","actor.mu.2.weight","actor.mu.2.bias","actor.mu.4.weight","actor.mu.4.bias"]
    actor_target = ["actor_target.mu.0.weight","actor_target.mu.0.bias","actor_target.mu.2.weight","actor_target.mu.2.bias","actor_target.mu.4.weight","actor_target.mu.4.bias"]
    critic_0 = ["critic.qf0.0.weight","critic.qf0.0.bias","critic.qf0.2.weight","critic.qf0.2.bias","critic.qf0.4.weight","critic.qf0.4.bias"]
    critic_0_target = ["critic_target.qf0.0.weight","critic_target.qf0.0.bias","critic_target.qf0.2.weight","critic_target.qf0.2.bias","critic_target.qf0.4.weight","critic_target.qf0.4.bias"]
    critic_1 = ["critic.qf1.0.weight","critic.qf1.0.bias","critic.qf1.2.weight","critic.qf1.2.bias","critic.qf1.4.weight","critic.qf1.4.bias"]
    critic_1_target = ["critic_target.qf1.0.weight","critic_target.qf1.0.bias","critic_target.qf1.2.weight","critic_target.qf1.2.bias","critic_target.qf1.4.weight","critic_target.qf1.4.bias"]

    # Map torch layer groups to tf models
    TORCH_LAYER_NAMES = [actor, actor_target, critic_0, critic_0_target, critic_1, critic_1_target]

    tf_models = {"actor": Actor(), 
                 "actor_target": Actor(),
                 "critic_0": Critic(),
                 "critic_0_target": Critic(),
                 "critic_1": Critic(),
                 "critic_1_target": Critic()
                }

    for model_num, model_name in enumerate(tf_models):
        for layer_num, layer in enumerate(TORCH_LAYER_NAMES[model_num]):
            torch_params = torch_models['policy'][layer]
            np_params = torch_params.cpu().numpy() # move to cpu memory then convert to numpy
            if layer_num % 2 == 0: # Torch weights shape is flipped
                np_params = np.reshape(np_params, (np_params.shape[1], np_params.shape[0])) 
            tf_weights = tf.convert_to_tensor(np_params)
            tf_models[model_name].trainable_variables[layer_num].assign(tf_weights)
    return tf_models

# Convert to torch should be used to initialize the mesa sb3 models with the TF meta parameters
def to_torch(tf_models):
    actor = ["actor.mu.0.weight","actor.mu.0.bias","actor.mu.2.weight","actor.mu.2.bias","actor.mu.4.weight","actor.mu.4.bias"]
    actor_target = ["actor_target.mu.0.weight","actor_target.mu.0.bias","actor_target.mu.2.weight","actor_target.mu.2.bias","actor_target.mu.4.weight","actor_target.mu.4.bias"]
    critic_0 = ["critic.qf0.0.weight","critic.qf0.0.bias","critic.qf0.2.weight","critic.qf0.2.bias","critic.qf0.4.weight","critic.qf0.4.bias"]
    critic_0_target = ["critic_target.qf0.0.weight","critic_target.qf0.0.bias","critic_target.qf0.2.weight","critic_target.qf0.2.bias","critic_target.qf0.4.weight","critic_target.qf0.4.bias"]
    critic_1 = ["critic.qf1.0.weight","critic.qf1.0.bias","critic.qf1.2.weight","critic.qf1.2.bias","critic.qf1.4.weight","critic.qf1.4.bias"]
    critic_1_target = ["critic_target.qf1.0.weight","critic_target.qf1.0.bias","critic_target.qf1.2.weight","critic_target.qf1.2.bias","critic_target.qf1.4.weight","critic_target.qf1.4.bias"]

    # Map tf models to torch layer groups. TODO: torch actor and actor target both recieve actor parameters, and so on for critic_0 & critic_1
    TORCH_LAYER_NAMES = [actor, critic_0, critic_1]
    TF_MODEL_NAMES = ["actor", "critic_0", "critic_1"]

    torch_dict = {}

    for model_num, model_name in enumerate(TF_MODEL_NAMES):
        for layer_num, layer in enumerate(TORCH_LAYER_NAMES[model_num]):
            tf_tensor = tf_models[model_name].trainable_variables[layer_num]
            np_params = tf_tensor.numpy()
            if layer_num % 2 == 0: # Torch weights shape is flipped
                np_params = np.reshape(np_params, (np_params.shape[1], np_params.shape[0])) 
            torch_tensor = torch.from_numpy(np_params)
            torch_dict[layer] = torch_tensor

    return {"policy": torch_dict}


def pl(name, var):
    print(name, var, '\n\n')

def conjugate_gradient(Av, b, x0, num_iterations):
    """
    Function from https://github.com/spiglerg/pyMeta
    See algorithm here: https://en.wikipedia.org/wiki/Conjugate_gradient_method

    solving for x in the equation A*x = b
    x0 is the initial guess (starts with 0s in the shape of trainable_variables)
    """
    Ax = Av(x0)

    r = [b[i] - Ax[i] for i in range(len(x0))]
    p = deepcopy(r)
    for i in range(num_iterations):
        Ap = Av(p)

        rTr = np.sum([ np.sum(r[k]*r[k]) for k in range(len(x0)) ])
        alpha = rTr / np.sum([ np.sum(p[k]*Ap[k]) for k in range(len(x0)) ])

        x = [x0[k] + alpha*p[k] for k in range(len(x0))]
        r = [r[k] - alpha*Ap[k] for k in range(len(x0))]

        avg_r = [tf.reduce_mean(r[k]).numpy() for k in range(len(x))] # list of avg r for weights and biases
        avg_r = sum(avg_r) / len(avg_r)

        if avg_r < gi_APPROXIMATION_THRESHOLD:
            return x

        beta = np.sum([ np.sum(r[k]*r[k]) for k in range(len(x)) ]) / rTr

        p = [r[k] + beta*p[k] for k in range(len(x))]

    return x



"""OffPolicyAlgorithm"""
class MetaTD3():
    def __init__(self):

        #self.observation_space = TaskEnv.observation_space
        #self.action_space = TaskEnv.action_space
        

        self.ros_interface = CatchInterface()
        self.env = MarshaGym(self.ros_interface)
        self.mesa_algo = TD3("MlpPolicy", self.env)
        self.tasks = [Task(self.env), Task(self.env)]
        self.replay_buffer = None # will use one of the task replay buffers
        self.lambda_reg = 2.0 # Regularization Strength (2.0 according to iMAML paper)

        self.meta_models = {"actor": Actor(), 
                            "critic_0": Critic(),
                            "critic_1": Critic()
                            }

        self.loss_functions = [self.actor_loss, self.critic_loss]


        self.optimized_mesa_models = None




    def _update_meta_parameters(self):
        meta_grads = {}
        for task in self.tasks:
            print("--------------- task -------------------------------")
            # Mesa models are returned after sb3 training
            self.replay_buffer, self.optimized_mesa_models = task.learn(self.meta_models)
            #pl("testing_observations:", self.replay_buffer.testing_data.observations)

            for model in self.meta_models:
                print("Training meta", model, "...")
                gi = self._calculate_implicit_meta_gradient(model)
                try:
                    meta_grads[model].append(gi)
                except KeyError:
                    meta_grads[model] = [gi]
            

        # Meta grads contains gradient for 3 models across the tasks
        for model in meta_grads:
            # Find average gradient for model across tasks
            weight_grads = [grad[0] for grad in meta_grads[model]]
            bias_grads = [grad[1] for grad in meta_grads[model]]

            weight_avg_grad = sum(weight_grads)/len(weight_grads)
            bias_avg_grad = sum(bias_grads)/len(bias_grads)

            OPTIMIZER.apply_gradients(zip([weight_avg_grad, bias_avg_grad], self.meta_models[model].trainable_variables))

    def _calculate_implicit_meta_gradient(self, model_id):
        """
        Approximate gradient as demonstrated in iMAML Eq. 7

        Meta gradient could be calculated with (I+1/lambda*H)*vi
            where H is the hessian matrix of the mesa training loss with respect to the final parameters,
            I is the identity matrix,
            lambda is the regularization strength hyperparameter,
            vi is the gradient of the mesa test loss with respect to the final parameters

        However, the hessian is impractical to calculate.
        This function approximates it with the conjugate gradient method and hessian-vector products
        The function can be approximated by minimizing w in (I+1/lambda*H)*w = vi

        The conjugate gradient method is used where:
            A = (I+1/lambda*H)
            b = vi

        The hessian vector product Hv is calculated with Pearlmutter (1994)'s method where:
            Hv = D(h*v)
            H = D(h)
            D(v) = 0
        """

        def Av(v):
            Hv = self._Hvp(model_id, v) # Hessian Vector Product
            return [v[i] + 1.0/self.lambda_reg * Hv[i].numpy() for i in range(len(v))]

        # vi, aka gradient of testing loss
        vi = self._calculate_partial_outer_gradient(model_id)

        parameters = [v.numpy() for v in self.optimized_mesa_models[model_id].trainable_variables]

        # x0 is a list with weights and biases replaced with zeros ex: [weights, bias] where weights = [[0, 0, 0], [0, 0, 0]]
        # it is the initial guess for A
        x0 = [np.zeros(var.shape, dtype=np.float32) for var in parameters]

        b = deepcopy(vi)

        x = conjugate_gradient(Av, b, x0, num_iterations=5)
        return x
        
    #@tf.function
    def _Hvp(self, model_id, v):
        """
        Computes a Hessian-vector product using the Pearlmutter method.
        The Hessian used is the loss function of tf.keras.Model 'model' with respect to its trainable_variables.
        The vector v is decomposed into a list of Tensors, to match the number of weights of 'model' and their shape.
        """
        loss_function = self.loss_functions[self.meta_models[model_id].loss_function_id]
        with tf.GradientTape() as outer_tape:
            with tf.GradientTape() as inner_tape:
                print("Train loss:")
                loss = loss_function(self.replay_buffer["train"].sample(META_BATCH_SIZE))
            grads = inner_tape.gradient(loss, self.optimized_mesa_models[model_id].trainable_variables)
        Hv = outer_tape.gradient(grads, self.optimized_mesa_models[model_id].trainable_variables, output_gradients=v)
        return Hv

    #@tf.function
    def _calculate_partial_outer_gradient(self, model_id):
        loss_function = self.loss_functions[self.meta_models[model_id].loss_function_id]
        with tf.GradientTape() as tape:
            print("Test Loss:")
            loss = loss_function(self.replay_buffer["test"].sample(META_BATCH_SIZE))
        grads = tape.gradient(loss, self.optimized_mesa_models[model_id].trainable_variables) # v_i in the iMAML paper
        return grads


    #@tf.function
    def actor_loss(self, replay_data):
        np_obs = replay_data.observations.cpu().numpy()
        np_obs = np.reshape(np_obs, (np_obs.shape[0], np_obs.shape[1] * np_obs.shape[2]))
        print("observation:", np_obs)
        actions = self.optimized_mesa_models["actor"](np_obs)
        qs = self.optimized_mesa_models["critic_0"](np_obs, actions) # Only predicts q-value with first network

        actor_loss = -1 * tf.reduce_mean(qs, axis=0)
        print("Actor loss:", actor_loss)
        return actor_loss

    # TODO: Add noise
    #@tf.function
    def critic_loss(self, replay_data):
        np_next_obs = replay_data.next_observations.cpu().numpy()
        np_next_obs = np.reshape(np_next_obs, (np_next_obs.shape[0], np_next_obs.shape[1] * np_next_obs.shape[2]))
        np_obs = replay_data.observations.cpu().numpy()
        np_obs = np.reshape(np_obs, (np_obs.shape[0], np_obs.shape[1] * np_obs.shape[2]))
        next_actions = self.optimized_mesa_models["actor_target"](np_next_obs)

        next_q_values_0 = self.optimized_mesa_models["critic_0_target"](np_next_obs, next_actions)
        next_q_values_1 = self.optimized_mesa_models["critic_1_target"](np_next_obs, next_actions)


        min_next_q = tf.math.minimum(next_q_values_0, next_q_values_1)

        gamma = 0.9
        target_q_values = replay_data.rewards.cpu().numpy() + (1 - replay_data.dones.cpu().numpy()) * gamma * min_next_q

        current_q_values_0 = self.optimized_mesa_models["critic_0"](np_obs, replay_data.actions.cpu().numpy())
        current_q_values_1 = self.optimized_mesa_models["critic_1"](np_obs, replay_data.actions.cpu().numpy())

        critic_loss = MSE(current_q_values_0, target_q_values) + MSE(current_q_values_1, target_q_values)
        print("Critic loss:", critic_loss)

        return critic_loss



    def train(self):
        meta_batch = meta_task_distribution.sample_batch() #TODO
        


def print_torch(tensor):
    np_tensor = tensor
    tf_tensor = tf.convert_to_tensor(np_tensor)
    print(tf.shape(tf_tensor))

if __name__ == "__main__":
    mtd = MetaTD3()

    pre_meta = mtd.meta_models["actor"].trainable_variables[0]
    mtd._update_meta_parameters()
    print("pre meta actor\n", pre_meta)
    
    print("post meta actor\n", mtd.meta_models["actor"].trainable_variables[0])

    #mtd._update_meta_parameters()


    #print(policy)

    
    # parameters: dict(policy, actor.optimizer, critic.optimizer)
    # policy contains parameters
    # the optimizers contain hyperparameters
    #parameters = gym.meta_model.get_parameters()

    # policy contains networks: 
    # (actor, actor_target, critic_0, critic_1, critic_target_0, critic_target_1)
    # each network has (weight, bias) for (0, 2, 4) layers?
    #policy = parameters['policy']
    #for key, value in policy.items():
    #    print(key)





