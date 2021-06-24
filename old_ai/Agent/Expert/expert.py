import threading
from numpy.core.fromnumeric import shape
import tensorflow as tf
from tensorflow.python.keras.engine.keras_tensor import KerasTensor
import tensorflow.python.keras.layers.convolutional as conv
from config import train_config as config

class Expert():
    def __init__(self) -> None:
        #threading.Thread.__init__(self)
        self.id = None
        self.input_shape = None
        self.output_shape = None

        self.memory = None
        self.state = None
        
        self.input = None
        self.output = None
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
        self.input_shape = None
        self.output_shape = None
        self.model = None

    def build_model(self, num_layers, units, activators, layer_type):
        # Could possibly be refactored into hidden expert
        try:
            initial = tf.keras.layers.Input(shape=self.input_shape)
        except Exception as e:
            print('Expert:', type(self))
            print('Input shape:', self.input_shape)
            raise e
        x = initial
        for i in range(0, num_layers):
            if layer_type[i] == tf.keras.layers.Dense:
                x = layer_type[i](units=units[i], activation=activators[i])(x)
            elif layer_type[i] == tf.keras.layers.Conv2D:
                x = layer_type[i](units[i], (3,3), activation=activators[i])(x)
                x = tf.keras.layers.MaxPool2D()(x)
            else:
                try:
                    x = layer_type[i]()(x)
                except Exception as e:
                    print('Layer type: ', layer_type[i])
                    raise e
        
        self.model = tf.keras.Model(initial, x)
        self.model.compile()


    def __call__(self, input):
        return self.model(input)

    def get_output(self):
        return self(self.input)

    def train(self, sarsa):
        state = None
        action = sarsa[1]
        reward = sarsa[2]
        next_state = None
        done = sarsa[4]

        next_qs = self(sarsa[3])
        next_state = next_qs
        max_next_qs = tf.reduce_max(next_qs, axis=1)

        target = sarsa[2] + config.discount_factor * max_next_qs
        target = target * (1 - sarsa[4]) - sarsa[4]
        
        with tf.GradientTape() as tape:
            qs = self(sarsa[0])
            state = qs
            action_mask = tf.one_hot(sarsa[1], self.output_shape)
            masked_qs = tf.reduce_sum(tf.multiply(qs, action_mask), axis=1)

            
            loss = config.mse(target, masked_qs)

        grads = tape.gradient(loss, self.model.trainable_variables)
        config.optimizer.apply_gradients(zip(grads, self.model.trainable_variables))

        return (state, action, reward, next_state, done)




        
