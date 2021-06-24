from .expert import Expert
import numpy as np
from PIL import Image


class Input_Expert(Expert):
    def set_input(self):
        raise ValueError("An input expert should not be given an input.")

class Lidar(Input_Expert):
    pass

class IMU(Input_Expert):
    pass

class Camera(Input_Expert):
    def __init__(self, in_shape) -> None:
        super().__init__()
        self.input_shape = in_shape
        self.output_shape = in_shape

    def get_output(self):
        return self.inp