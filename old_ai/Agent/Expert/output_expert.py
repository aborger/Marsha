import tensorflow as tf
from .expert import Neural_Expert
import util

class Output_Expert(Neural_Expert):
    pass

class Stepper_Motor(Output_Expert):
    pass


class DC_Motor(Output_Expert):
    def __init__(self, input_shape):
        super().__init__()
        util.exists(self, input_shape)
        self.input_shape = input_shape
        self.output_shape = 1

        self.build_model(num_layers=2,
                        units=[10, self.output_shape],
                        activators=['sigmoid', 'sigmoid'],
                        layer_type=[
                            tf.keras.layers.Dense,
                            tf.keras.layers.Dense
                        ])

