from re import L
from tensorflow import keras
from tensorflow.python.keras import activations
from tensorflow.python.keras.backend import softmax
from .expert import Expert, Neural_Expert
import numpy as np
import tensorflow as tf
from config import train_config as config

class Hidden_Expert(Neural_Expert):
    def __init__(self, input_shape, output_shape) -> None:
        super().__init__(input_shape, output_shape)


class RNN(Hidden_Expert):
    pass

class Dense(Hidden_Expert):
    def __init__(self, input_shape):
        super().__init__(input_shape)
        num_layers = 4
        units = [4, 15, 20, self.output_shape]
        activators = ['sigmoid', 'sigmoid', 'softmax', softmax]
        layer_type = [
            tf.keras.layers.Dense, 
            tf.keras.layers.Dense,
            tf.keras.layers.Dense,
            tf.keras.layers.Dense]

        # Could possibly be refactored into hidden expert
        self.layers = []
        self.layers.append(tf.keras.layers.Input(shape=input_shape))
        for i in num_layers:
            layer = layer_type[i](units=units[i], activation=activators)
            self.layers.append(layer)

class CNN(Hidden_Expert):
    def __init__(self, input_shape):
        super().__init__(input_shape)
        num_layers = 3
        filters = [32, 64, 64]
        activators = ['relu', 'relu', 'relu']

        layer_type = [
            tf.keras.layers.Conv2D,
            tf.keras.layers.Conv2D,
            tf.keras.layers.Conv2D,
        ]

        self.layers = []
        self.layers.append(tf.keras.layers.Input(shape=input_shape))
        for i in num_layers:
            layer = layer_type[i](filters[i], (3,3), activation=activators[i])
            self.layers.append(layer)
            self.layers.append(tf.keras.layers.MaxPool2D())
        self.layers.append(tf.keras.layers.Flatten())


class AugTop():
    pass