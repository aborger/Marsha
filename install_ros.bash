#!/bin/bash
echo Installing MARSHA...
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
yes | sudo apt install curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
yes | sudo apt install ros-melodic-ros-base
yes | sudo apt install python3-pip python3-all-dev python3-rospkg
yes | sudo apt install ros-melodic-ros-base --fix-missing
yes | sudo apt install ros-melodic-moveit
yes | sudo apt install ros-melodic-moveit-visual-tools
yes | sudo apt install ros-melodic-pcl-ros
yes | sudo apt install ros-melodic-hardware-interface
yes | sudo apt install ros-melodic-ros-control
yes | sudo apt install ros-melodic-ros-controllers
source /opt/ros/melodic/setup.bash
mkdir -p ~/catkin_ws/src
cd ~
mv ~/marsha ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://github.com/aborger/ar3_core
git clone https://github.com/ros/executive_smach.git -b indigo-devel

echo -e "
source ~/catkin_ws/devel/setup.bash
export ROS_HOSTNAME=$HOSTNAME \n
# Change which device is connected to
export ROS_MASTER_URI=http://$HOSTNAME:11311
" >> ~/.bashrc
