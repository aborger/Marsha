#!/bin/bash
# TODO: make a setup script for the embedded platform
echo Installing MARSHA...
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
yes | sudo apt install curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
yes | sudo apt install ros-melodic-desktop-full
yes | sudo apt install python3-pip python3-all-dev python3-rospkg
yes | sudo apt install ros-melodic-moveit
yes | sudo apt install ros-melodic-moveit-visual-tools
yes | sudo apt install ros-melodic-pcl-ros
yes | sudo apt install ros-melodic-gazebo-ros
source /opt/ros/melodic/setup.bash
mkdir -p ~/catkin_ws/src
cd ~
mv ~/marsha ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://github.com/jenniferbuehler/gazebo-pkgs
rm -r gazebo-pkgs/gazebo_state_plugins
rm -r gazebo-pkgs/gazebo_test_tools
git clone https://github.com/aborger/ar3_core
cd ~/catkin_ws

catkin_make
source ~/catkin_ws/devel/setup.bash >> ~/.bashrc
