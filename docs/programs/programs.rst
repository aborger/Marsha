
Programs
=============

The following provides different commands to launch the robotic arms. Note that any combination of arguments can be used.

Simulation
---------------
Launch program with: ::
    
    roslaunch arm2d2 simulate.launch

Currently, the balls will be stacked after launching, this is because specifying the argument "no_grav" in the simulate.launch file does not work. Running a new reset node will fix this: ::

    rosrun marsha_gazebo reset no_grav

Simulation with both arms:
--------------------------
::
    roslaunch arm2d2 simulate.launch num_arms:=2

Simulation with RVIZ control interface:
--------------------------
::
    roslaunch arm2d2 simulate.launch launch_rviz:=true

RVIZ is a way to control the robot and see where it plans to move. Simply open the RVIZ window and drag the end effector marker to the desired position and then press plan and execute. The Gazebo simulated robot will move to this position and orientation, this works for the hardware robot as well. Individual joints can be controlled with RVIZ as well.

Simulation with the top plate:
------------------------
::
    roslaunch arm2d2 simulate.launch top_plate:=true

Note: Collisions for top plate and surrounding obstacles are not simulated in Gazebo, but moveit avoids colliding with them. Collisions can be turned on by editing marsha/arm2d2/arm2d2_description/urdf/base.urdf.xacro. 
TODO: Toggle collisions from the launch file.



