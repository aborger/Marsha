@echo off
set num_episodes=%1
echo Running nn...
set PYTHONHOME=
set PYTHONPATH="C:\Python38\"
set ROS_IP=192.168.155.16
set ROS_MASTER_URI=http://jet:11311
"C:\Program Files\Python38\python" "C:\Users\borge\MARSHA\ros_dev\pc\catkin_ws\src\marsha\src\nn.py" %num_episodes%