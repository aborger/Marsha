
Robot Control Services
==============

The move interface node on the Embedded Platform (marsha_core/nodes/move_interface.cpp) provides an interface to control the robot. These are some examples of how to control it.

This list of services provides ways to control the arm through the command prompt. These services can also be called from other nodes. The command prompt syntax to call one of these services is as follows:

``` rosservice call /<Arm Name>/<Service Name> <Command> ```

<Arm Name> is replaced with either `left` or `right`.
<Service Name> is replaced by the name of the service provided in the following documentation.
<Command> is replaced by the service specific command.

Example:
``` rosservice call /left/joint_pose_cmd pre_ball_1 ```


Pose Command Service ``/rns/pose_cmd``
--------------------
``pose_cmd``

Moves the arm to a preset position and orientation.

Command:
Name of a pose specified in the preset poses file (marsha/arm2d2/arm2d2/config/poses.yaml).

Call Example:
``` rosservice call /left/pose_cmd pre_throw ```


Async Pose Command Service
--------------------------
``async_pose_cmd``

This is the same as pose command, but it does not wait until the arm has finished moving.

Command:
Name of a pose specified in the preset poses file (marsha/arm2d2/arm2d2/config/poses.yaml).

Call Example:
``` rosservice call /left/async_pose_cmd pre_throw ```

Joint Command Service
---------------------
``joint_pose_cmd``

Moves the arm to a preset joint pose with specified angles for each joint.

Command:
Name of a joint pose specified in the preset poses file (marsha/arm2d2/arm2d2/config/poses.yaml).

Call Example:
``` rosservice call /left/async_pose_cmd pre_ball_1```


Fold Command Service
--------------------
`folding`

Folds or unfolds the arm. Folding is also configured in the preset poses file. It sequentially calls `rosservice call /left/joint_pose_cmd folding/step_i` for each step specified.

Command:
`fold` or `unfold`

Call Example:
``` rosservice call /left/folding unfold ```


Gripper Command Service
-------------------------
`gripper/grasp_cmd`

Opens and closes the gripper.
Positions be configured in aborger/Marsha/tundra_gripper/config/poses.yaml

Command:
`open`, `close`, `half`, `half_closed`

Call Example:
``` rosservice call /left/gripper/grasp_cmd close ```

Grasp Check
----------------------
`gripper/is_grasped`
Returns a boolean value representing if an object is grasped or not.

Call Example:
``` rosservice call /left/gripper/is_grasped ```