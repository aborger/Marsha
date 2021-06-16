from re import L
from .expert import Expert, Neural_Expert
import numpy as np
import tensorflow as tf
from config import train_config as config

class Hidden_Expert(Neural_Expert):
    def __init__(self) -> None:
        super().__init__()


class RNN(Hidden_Expert):
    pass

class Dense(tf.keras.Model, Hidden_Expert):
    def __init__(self, input_shape):
        super(Dense, self).__init__()
        self.in_shape = input_shape

        num_layers = 3
        self.out_shape = 15
        units = [4, 15, self.out_shape]
        activators = ['sigmoid', 'sigmoid', 'sigmoid']
        layer_type = [
            tf.keras.layers.Dense, 
            tf.keras.layers.Dense,
            tf.keras.layers.Dense]

        # Could possibly be refactored into hidden expert
        self.expert_layers = []
        self.expert_layers.append(tf.keras.layers.Input(shape=input_shape))
        for i in range(0, num_layers):
            layer = layer_type[i](units=units[i], activation=activators[i])
            self.expert_layers.append(layer)

    def call(self, input):
        self.call_func(input)

class CNN(tf.keras.Model, Hidden_Expert):
    def __init__(self, input_shape):
        Hidden_Expert().__init__()
        super(CNN, self).__init__()
        self.in_shape = input_shape

        num_layers = 3
        self.out_shape = 64
        filters = [32, 64, self.out_shape]
        activators = ['relu', 'relu', 'relu']

        layer_type = [
            tf.keras.layers.Conv2D,
            tf.keras.layers.Conv2D,
            tf.keras.layers.Conv2D,
        ]

        self.expert_layers = []
        print('Input shape: ', input_shape)
        self.expert_layers.append(tf.keras.layers.Input(shape=input_shape))
        for i in range(0, num_layers):
            layer = layer_type[i](filters[i], (3,3), activation=activators[i])
            self.expert_layers.append(layer)
            self.expert_layers.append(tf.keras.layers.MaxPool2D())
        self.expert_layers.append(tf.keras.layers.Flatten())

    def call(self, input):
        self.call_func(input)


class AugTop():
    pass