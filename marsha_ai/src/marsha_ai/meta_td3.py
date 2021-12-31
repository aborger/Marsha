#!/usr/bin/env python3

import gym
from stable_baselines3 import TD3

from marsha_ai import catch_bandit
from marsha_ai.catch_bandit.gym_env import MarshaGym
from marsha_ai.catch_bandit.catch_interface import CatchInterface

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

class Observation: # Unit Test
    def __init__(self, num_batches, observation_len, action_len):
        self.observations = tf.constant(np.random.rand(num_batches, observation_len).astype('f'))
        self.next_observations = tf.constant(np.random.rand(num_batches, observation_len).astype('f'))
        self.actions = tf.constant(np.random.rand(num_batches, action_len).astype('f'))
        self.rewards = tf.constant(np.random.rand(num_batches, 1).astype('f'))
        self.dones = tf.constant(np.zeros(shape=(num_batches, 1)).astype('f'))


# TODO: Get replay buffer from TD3 with TD3.collect_rollouts()
class Replay_Buffer: # Unit Test
    def __init__(self, observation_len, num_batches):
        np.random.rand(num_batches, observation_len)
        self.testing_data = Observation(num_batches, observation_len, observation_len)
        self.training_data = Observation(num_batches, observation_len, observation_len)


class Task:
    def __init__(self, observation_space, action_space, env):
        batch_size = 2 # number of steps in reinforcement learning
        self.replay_buffer = Replay_Buffer(get_flattened_obs_dim(observation_space), batch_size)

        self.observation_space = observation_space
        self.action_space = action_space
        self.env = env


    def learn(self, initial_models):
        mesa_algo = TD3("MlpPolicy", self.env, verbose=1) # Note: Unecessarily initializes parameters (could speed up a bit by fixing)
        #mesa_model.set_parameters(self.meta_model.get_parameters(), exact_match=True)
        """
        mesa_models = {"actor": Actor(self.observation_space, self.action_space), 
                    "actor_target": Actor(self.observation_space, self.action_space),
                    "critic_0": Critic(self.observation_space, self.action_space),
                    "critic_1": Critic(self.observation_space, self.action_space),
                    "critic_target_0": Critic(self.observation_space, self.action_space),
                    "critic_target_1": Critic(self.observation_space, self.action_space)
                    }
        """

        mesa_parameters = mesa_algo.get_parameters()
        for param in mesa_parameters['policy']:
            print(param)
        return self.replay_buffer, mesa_models

class Actor(tf.keras.Model):
    def __init__(self, observation_space, action_space):
        super().__init__()
        
        self._initialize(observation_space, action_space)

        self.call(tf.constant(np.zeros(observation_space.sample().shape).astype('f'))) # Initialize parameters by calling

        self.loss_function_id = ACTOR_LOSS

    """
    debug

    def _initialize(self, observation_space, action_space):
        self.dense1 = tf.keras.layers.Dense(get_action_dim(action_space), input_shape=observation_space.sample().shape)

    def call(self, inputs):
        x = self.dense1(inputs)
        return x
    """

    def _initialize(self, observation_space, action_space):
        self.dense1 = tf.keras.layers.Dense(400, input_shape=observation_space.sample().shape, activation='relu')
        self.dense2 = tf.keras.layers.Dense(300, activation='relu')
        self.dense3 = tf.keras.layers.Dense(get_action_dim(action_space), activation='tanh')

    def call(self, inputs):
        x = self.dense1(inputs)
        x = self.dense2(inputs)
        x = self.dense3(inputs)
        return x

class Critic(tf.keras.Model):
    def __init__(self, observation_space, action_space):
        super().__init__()
        
        self._initialize(observation_space, action_space)

        # Initialize parameters by calling
        self.call(
            tf.constant(np.zeros(shape=(1, get_flattened_obs_dim(observation_space)))),
            tf.constant(np.zeros(shape=(1, get_action_dim(action_space))))
            ) 
        self.loss_function_id = CRITIC_LOSS

    """
    Debug

    def _initialize(self, observation_space, action_space):
        input_len = get_flattened_obs_dim(observation_space) + get_action_dim(action_space)
        self.dense1 = tf.keras.layers.Dense(1, input_shape=input_shape)

    def call(self, observations, actions):
        inputs = tf.concat([observations, actions], axis=1)
        x = self.dense1(inputs)
        return x
    """
    def _initialize(self, observation_space, action_space):
        self.dense1 = tf.keras.layers.Dense(400, input_shape=(get_flattened_obs_dim(observation_space) + get_action_dim(action_space),), activation='relu')
        self.dense2 = tf.keras.layers.Dense(300, activation='relu')
        self.dense3 = tf.keras.layers.Dense(1)

    def call(self, observations, actions):
        inputs = tf.concat([observations, actions], axis=1)
        x = self.dense1(inputs)
        x = self.dense2(inputs)
        x = self.dense3(inputs)
        return x



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

        self.observation_space = catch_bandit.observation_space
        self.action_space = catch_bandit.action_space
        

        self.ros_interface = CatchInterface()
        self.env = MarshaGym(self.ros_interface)
        self.mesa_algo = TD3("MlpPolicy", self.env)
        self.tasks = [Task(self.observation_space, self.action_space, self.env), Task(self.observation_space, self.action_space, self.env)]
        self.replay_buffer = None # will use one of the task replay buffers
        self.lambda_reg = 2.0 # Regularization Strength (2.0 according to iMAML paper)
        self.meta_models = None # (meta_actor, meta_critic_0, meta_critic_1)

        self.loss_functions = [self.actor_loss, self.critic_loss]

        # Large variables updated after each task
        self.replay_buffer = None
        self.optimized_mesa_models = None


    def _initialize_meta_models(self):
        # Create Actor and Critic Architecture according to stable-baselines TD3 and TD3 paper
        
        self.meta_models = {"actor": Actor(self.observation_space, self.action_space), 
                            "critic_0": Critic(self.observation_space, self.action_space),
                            "critic_1": Critic(self.observation_space, self.action_space)
                            }

        for model in self.meta_models:
            print(model, "initial parameters:\n")
            print(self.meta_models[model].trainable_variables, "\n\n")


    def _update_meta_parameters(self):
        meta_grads = {}
        for task in self.tasks:
            print("--------------- task -------------------------------")
            # Mesa models are returned after sb3 training
            self.replay_buffer, self.optimized_mesa_models = task.learn(self.meta_models)
            pl("testing_observations:", self.replay_buffer.testing_data.observations)
            pl("op mesa models:", self.optimized_mesa_models["actor"].trainable_variables)

            for model in self.meta_models:
                pl("model:", model)
                gi = self._calculate_implicit_meta_gradient(model)
                pl("gi:", gi)
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

            print("new_parameters for ", model, ": ", self.meta_models[model].trainable_variables)

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

        pl("vi:", vi)

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
                loss = loss_function(self.replay_buffer.training_data)
            grads = inner_tape.gradient(loss, self.optimized_mesa_models[model_id].trainable_variables)
        Hv = outer_tape.gradient(grads, self.optimized_mesa_models[model_id].trainable_variables, output_gradients=v)
        return Hv

    #@tf.function
    def _calculate_partial_outer_gradient(self, model_id):
        loss_function = self.loss_functions[self.meta_models[model_id].loss_function_id]
        with tf.GradientTape() as tape:
            loss = loss_function(self.replay_buffer.testing_data)
        grads = tape.gradient(loss, self.optimized_mesa_models[model_id].trainable_variables) # v_i in the iMAML paper
        return grads


    @tf.function
    def actor_loss(self, replay_data):
        actions = self.optimized_mesa_models["actor"](replay_data.observations)
        qs = self.optimized_mesa_models["critic_0"](replay_data.observations, actions) # Only predicts q-value with first network

        actor_loss = -1 * tf.reduce_mean(qs, axis=0)
        return actor_loss

    # TODO: Add noise
    @tf.function
    def critic_loss(self, replay_data):
        next_actions = self.optimized_mesa_models["actor_target"](replay_data.next_observations)

        next_q_values_0 = self.optimized_mesa_models["critic_target_0"](replay_data.next_observations, next_actions)
        next_q_values_1 = self.optimized_mesa_models["critic_target_1"](replay_data.next_observations, next_actions)


        min_next_q = tf.math.minimum(next_q_values_0, next_q_values_1)

        gamma = 0.9
        target_q_values = replay_data.rewards + (1 - replay_data.dones) * gamma * min_next_q

        current_q_values_0 = self.optimized_mesa_models["critic_0"](replay_data.observations, replay_data.actions)
        current_q_values_1 = self.optimized_mesa_models["critic_1"](replay_data.observations, replay_data.actions)

        critic_loss = MSE(current_q_values_0, target_q_values) + MSE(current_q_values_1, target_q_values)

        return critic_loss



    def train(self):
        meta_batch = meta_task_distribution.sample_batch() #TODO
        


def print_torch(tensor):
    np_tensor = tensor
    tf_tensor = tf.convert_to_tensor(np_tensor)
    print(tf.shape(tf_tensor))

if __name__ == "__main__":
    mtd = MetaTD3()

    #mtd.tasks[0].learn(mtd.meta_models)
    mtd._initialize_meta_models()
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





