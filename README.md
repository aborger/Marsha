# MARSHA
### (Meta AI Robotic Spacecraft Handy Arm)

MARSHA is part of a research project at Northwest Nazarene University studying the use of Meta-Reinforcement Learning for robotics to account for inaccuracies between simulation and real-world, zero-gravity physics.

This work proposes a method to train an agent in simulation with the TD3 algorithm which is a model-free policy optimisation deep reinforcement learning method. A model-agnostic meta learning method for reinforcement learning is utilized that allows the model to be retrained in space with only a few shots despite never being tested in the real world space environment. This work begins to demonstrate these methods by catching a ball in space with a robotic manipulator, but creates an opportunity for further work catching varying shaped objects in space which would be beneficial towards solving multiple challenging problems such as assisting astronauts, space debris removal, and in-orbit assembly and servicing of spacecraft. Catching the object is viewed as a multi-armed bandit problem where the agent receives one observation and performs one action during the course of each episode; where the observation is the position and velocity of the object as determined from a 3D point cloud and the action is a tailored latent space representation of a grasp.


This repository is meant for a multi-device network composed of embedded system platforms (Jetson Nano or Raspberry Pi), GPU Trainer Platforms, and Auxilary platforms (remote control and simulation). There are multiple branches in the repository with each branch designed for its respective platform. The repository also includes many ROS submodules. To clone please use the following command:
```
git clone -b <PLATFORM BRANCH> --single-branch --recurse-submodules https://github.com/aborger/MARSHA
```
Where ```<PLATFORM BRANCH>``` is the repository branch which represents the system you are cloning onto.

Check out the [Wiki](https://github.com/aborger/Marsha/wiki) for documentation and further instructions.


