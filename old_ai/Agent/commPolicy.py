# Comm policy, also known as the expert policy

import numpy as np
from AI.Agent.Expert import input_expert
from AI.Agent.Expert import output_expert
from AI.Agent.Expert import hidden_expert
from AI.Agent.Expert.expert import Expert, Neural_Expert
import util
  
    

class Comm_Policy:
    def __init__(self):
        # 'self.conn_map' is an adjacency matrix, note: the rows feed into the columns
        self.conn_map = None
        self.num_experts = None
        # using this is a debate between speed and memory
        self.input_experts = []
        self.output_experts = []
        self.hidden_experts = []
        self.experts = []
        
    def load_maps(self, type_map: str, conn_map: str) -> None:
        type_map = np.load(file=type_map)
        self.conn_map = np.load(file=conn_map)
        self._check_maps(type_map)
        


    def create_maps(self):
        NUM_EXPERTS = 18
        type_map = np.empty(shape=(NUM_EXPERTS), dtype=Expert)
        self.conn_map = np.full(shape=(NUM_EXPERTS, NUM_EXPERTS), fill_value=False, dtype=bool)

        type_map[0] = input_expert.Camera((227, 512, 3))
        type_map[1] = hidden_expert.CNN(type_map[0].output_shape)
        util.exists(type_map[1], type_map[1].output_shape)
        type_map[2] = hidden_expert.Dense(type_map[1].output_shape)
        for i in range(3, NUM_EXPERTS):
            type_map[i] = output_expert.DC_Motor(type_map[2].output_shape)

        self.conn_map[0,1] = True
        self.conn_map[1, 2] = True
        self.conn_map[2, 3:] = True
        self._check_maps(type_map)

    def _check_maps(self, type_map):
        # Error checking
        if type_map.shape[0] != self.conn_map.shape[0]:
            raise ValueError("'type_map' and 'conn_map' must contain the same number of elements: type_map =", type_map.shape, 'conn_map = ', self.conn_map.shape)
        if self.conn_map.shape[0] != self.conn_map.shape[1]:
            raise ValueError("'conn_map' must be square.")

        self.num_experts = type_map.shape[0]

        self.experts = type_map

        for id in range(0, len(type_map)):
            expert = type_map[id]
            expert.id = id
            if isinstance(expert, input_expert.Input_Expert):
                self.input_experts.append(expert)
            elif isinstance(expert, hidden_expert.Hidden_Expert):
                self.hidden_experts.append(expert)
            elif isinstance(expert, output_expert.Output_Expert):
                self.output_experts.append(expert)
            else:
                raise TypeError("Expert does not have expert type. Type: ", type(expert))


    def execute_policy(self, state):
        # Should parallize this
        for expert in self.input_experts:
            expert.inp = state
        # hidden experts
        for row in range(0, self.num_experts):
            expert = self.experts[row]
            input = self.experts[row].get_output()
            for col in range(0, self.num_experts):
                if (self.conn_map[row, col]):
                    self.experts[col].set_input(input)

        output = []
        for expert in self.output_experts:
            out = expert.get_output().numpy()
            out = out[0][0]
            output.append(out)
        output = np.array(output)
        return output

    def random_actions(self):
        return np.random.rand(len(self.output_experts))

    def outer_train(self):
        pass

    def inner_train(self, passed_sarsa):
        sarsa = passed_sarsa
        for expert in self.hidden_experts:
            if isinstance(expert, Neural_Expert):
                sarsa = expert.train(sarsa)

            else:
                raise TypeError("Cannot train a non-neural expert.")

        for expert in self.output_experts:
            if isinstance(expert, Neural_Expert):
                expert.train(sarsa)

            else:
                raise TypeError("Cannot train a non-neural expert.")
            
            





        

