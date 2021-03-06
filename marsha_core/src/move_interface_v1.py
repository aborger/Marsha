#!/usr/bin/env python

import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
import sys
from marsha_ai.msg import Pos
from moveit_msgs.srv import GetStateValidity
from std_srvs.srv import Empty

MOVE_STEP = 1.0

class MarshaMoveInterface():
    def __init__(self):
        moveit_commander.roscpp_initialize(sys.argv)
        rospy.init_node('ar3_AI_controller')
        robot = moveit_commander.RobotCommander()

        scene = moveit_commander.PlanningSceneInterface()
        group_name = "manipulator"
        self._move_group = moveit_commander.MoveGroupCommander(group_name)

        rospy.Subscriber('AI_pos', Pos, self.posCallBack)
        rospy.wait_for_service('/check_state_validity')
        rospy.wait_for_service('/get_planning_scene')
        check_for_valid_pos = rospy.ServiceProxy('/check_state_validity', GetStateValidity)
        get_planning_scene = rospy.ServiceProxy('/get_planning_scene', Empty)
        self.planning_scene = get_planning_scene()

    def setPose(self):
        target_pose1 = geometry_msgs.msg.Pose()
        target_pose1.orientation.w = 0.5
        target_pose1.orientation.x = -0.5
        target_pose1.orientation.y = -0.5
        target_pose1.orientation.z = 0.5
        target_pose1.position.x = 0.0
        target_pose1.position.y = -0.40
        target_pose1.position.z = 0.30
        self._move_group.set_pose_target(target_pose1)

        plan = self._move_group.go(wait=True)

        self._move_group.stop()
        self._move_group.clear_pose_targets()

    def _check_state(self, pose):
        

        
        

    def posCallBack(self, msg):
        rospy.loginfo('Taking action: ' + str(msg))
        
        current_pose = self._move_group.get_current_pose().pose

        pose_goal = geometry_msgs.msg.Pose()
        pose_goal.orientation.w = 1.0
        pose_goal.position.x = current_pose.position.x + msg.x * MOVE_STEP
        pose_goal.position.y = current_pose.position.y + msg.y * MOVE_STEP
        pose_goal.position.z = current_pose.position.z + msg.z * MOVE_STEP


        self._move_group.set_pose_target(pose_goal)

        plan = self._move_group.go(wait=True)

        self._move_group.stop()
        self._move_group.clear_pose_targets()

if __name__ == "__main__":
    try:
        interface = MarshaMoveInterface()
        rospy.spin()
    except KeyboardInterrupt:
        rospy.logwarn('Exiting...')





