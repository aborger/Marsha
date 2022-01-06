from gym import spaces
import numpy as np
import math
# action_space: (r, theta, phi, trajectory_slice, grasp_time, close_time)
# r, theta, and phi represent polar coordinates of a grasp
# trajectory slice is the point along the trajectory the grasp will occur at
# the grasp_time is an offset from the predicted time to perform the grasp
# Could also include grasp close speed


action_space_min = np.array([0, 0, 0, 0, 0, 0]) 
action_space_max = np.array([1, math.pi, 2*math.pi, 1, 2, 1])
action_space = spaces.Box(action_space_min, action_space_max)

# Observation space: (Object position, Object velocity)
observation_space = spaces.Box(low=-1, high=1, shape=(2, 3))



dbug_action_space = spaces.Box(np.array([0, 0]), np.array([1, 1]))
dbug_observation_space = spaces.Box(low=-1, high=1, shape=(2,))
