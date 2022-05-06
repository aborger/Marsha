echo -e "
source ~/catkin_ws/devel/setup.bash
export ROS_HOSTNAME=$HOSTNAME
# Change which device is connected to
export ROS_MASTER_URI=http://$HOSTNAME:11311
" >> ~/.bashrc

