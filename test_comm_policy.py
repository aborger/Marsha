from AI.Agent.commPolicy import Comm_Policy

type_file = input("Enter type file location:")
conn_file = input("Enter connections file location:")

comm = Comm_Policy()
comm.create_maps()

print('Connection File: ', comm.conn_map)
print('Input Experts: ', comm.input_experts)
print('Hidden Experts: ', comm.hidden_experts)
print('Output Experts: ', comm.output_experts)