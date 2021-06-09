from tensorflow import keras


NUM_ACTIONS = 4

# These variables can be changed to get better results
num_episodes = 120           # Number of training sessions
initial_epsilon = 1         # Starting value of epsilon
epsilon_discount = 0.95     # Epsilon is multiplied by this value after each episode (decreases rate of random actions)
batch_size = 4             # Number of bars/frames to run before training
discount_factor = 0.99      # How important future rewards are (Part of the Bellman Equation)
copy_rate = 100            # The number of frames before target rnn is copied to main rnn
print_rate = 10             # Number of episodes before printing current results
goal_reward = 1000          # The reward that will deem an episode successfull
max_frames = 100             # Number of frames that will deem an episode unsuccessfull if the goal_reward is not reached

epsilon = 1

optimizer = keras.optimizers.Adam(1e-4)
mse = keras.losses.MeanSquaredError()