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
    def __init__(self, image_file) -> None:
        super().__init__()
        self.image_file = image_file

    def get_output(self):
        self.input = np.asarray(Image.open("../Unity/Rocksat/IMGS/img.jpg"))
        return super().get_output()