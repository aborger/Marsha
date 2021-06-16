# State is updated during the inner loop over iterations of trying to solve an environment

class State:
    def __init__(self):
        self.num_layers = None
        self.num_nodes_per_layer = None