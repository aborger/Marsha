import threading
import tensorflow as tf
from config import train_config as config

class Expert():
    def __init__(self) -> None:
        #threading.Thread.__init__(self)
        self.id = None
        self.in_shape = None
        self.out_shape = None

        self.memory = None
        self.state = None
        
        self.inp = None
        self.out = None
        self.output_ready = None


    def get_output(self):
        if self.output is None:
            raise ValueError("Expert output is None.")
        else:
            return self.output

    def calculate(self):
        raise NotImplementedError

    def set_input(self, input):
        self.input = input

class Neural_Expert(Expert):
    # Could be refactored, because every one of these has generally the same thing
    def __init__(self) -> None:
        super().__init__()
        #tf.keras.Model(model, self).__init__()

    def build(self):
        # Necessary for saving the model
        pass

    def call_func(self, input):
        print('call input: ', input)
        print('input shape: ', input.shape)
        print('type: ', input.dtype)
        x = input
        for layer in self.layers:
            x = layer(x)
            print(x)
        return x

    def get_output(self):
        return self.call(self.input)

    def train(self, sarsa):
        print('TRAINING... type:', type(self))
        state = sarsa[0]
        action = sarsa[1]
        reward = sarsa[2]
        next_state = sarsa[3]
        done = sarsa[4]

        next_qs = self.call(next_state)
        max_next_qs = tf.reduce_max(next_qs, axis=1)

        target = reward + config.discount_factor * max_next_qs
        target = target * (1 - done) - done
        
        with tf.GradientTape() as tape:
            qs = self.call(state)
            action_mask = tf.one_hot(action, self.output_shape)
            masked_qs = tf.reduce_sum(tf.multiply(qs, action_mask), axis=1)

            loss = config.mse(target, masked_qs)

        grads = tape.gradient(loss, self.trainable_variables)
        config.optimizer.apply_gradient(zip(grads, self.trainable_variables))




        
