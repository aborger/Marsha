# MARSHA
### (Meta AI Robotic Spacecraft Handy Arm)

MARSHA is part of a research project at Northwest Nazarene University studying the use of Meta-Reinforcement Learning for robotics to account for inaccuracies between simulation and real-world, zero-gravity physics. The project includes developing a pair of robotic arms that will use Multi-Agent communication to maneuver objects in space by throwing and catching them. The use of meta-learning allows the robotic arms to complete the task after training in a simulated environment and after a few training attempts in the real-world zero-gravity environment. Therefore, once the robotic arms have been fully trained, they can be used in space to move objects large distances while using electric motors instead of propellant.

This repository is meant for a multi-device network composed of embedded system platforms (Jetson Nano or Raspberry Pi), GPU Trainer Platforms, and Auxilary platforms (remote control and simulation). The repository also includes many ROS submodules. To clone please use the following command:
```
git clone -b <PLATFORM BRANCH> --single-branch --recurse-submodules https://github.com/aborger/MARSHA
```
Where ```<PLATFORM BRANCH>``` is the repository branch which represents the system you are cloning onto.

