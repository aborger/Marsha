from tensorflow.python.keras.backend import softmax
from .expert import Neural_Expert
import tensorflow as tf

class Output_Expert(Neural_Expert):
    pass

class Stepper_Motor(Output_Expert):
    pass

class DC_Motor(Output_Expert):
    def __init__(self, in_shape):
        super().__init__()
        self.in_shape = in_shape
        num_layers = 2
        units = [10, 1]
        activators = ['sigmoid', 'softmax']
        layer_type = [
            tf.keras.layers.Dense, 
            tf.keras.layers.Dense]

        # Could possibly be refactored into hidden expert
        self.expert_layers = []
        self.expert_layers.append(tf.keras.layers.Input(shape=in_shape))
        for i in range(0, num_layers):
            layer = layer_type[i](units=units[i], activation=activators[i])
            self.expert_layers.append(layer)

    def call(self, input):
        self.call_func(input)
