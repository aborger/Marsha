from re import L, M
from tensorflow.python.framework.func_graph import flatten

from tensorflow.python.keras.layers.convolutional import Conv2D
from tensorflow.python.ops.nn_ops import max_pool2d
from .expert import Expert, Neural_Expert
import numpy as np
import tensorflow as tf
import tensorflow.keras.layers as k
from config import train_config as config
import util

class Hidden_Expert(Neural_Expert):
    def __init__(self) -> None:
        super().__init__()


class RNN(Hidden_Expert):
    pass

class Dense(Hidden_Expert):
    def __init__(self, input_shape):
        super().__init__()
        util.exists(self, input_shape)

        self.input_shape = input_shape
        self.output_shape = 15

        self.build_model(num_layers=3,
                        units=[4, 15, self.output_shape], 
                        activators=['sigmoid', 'sigmoid', 'sigmoid'],
                        layer_type = [k.Dense, k.Dense, k.Dense])
        

class CNN(Hidden_Expert):
    def __init__(self, input_shape):
        super().__init__()
        self.input_shape = input_shape
        self.output_shape = 10

        self.build_model(num_layers=5,
                        units=[8, 8, 16, None, 10],
                        activators=['relu', 'relu', 'relu', None, 'sigmoid'],
                        layer_type=[k.Conv2D, k.Conv2D, k.Conv2D, k.Flatten, k.Dense])


class AugTop():
    pass