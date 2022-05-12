#!/usr/bin/env python
import rospy

from marsha_msgs.srv import MoveCmd

ns = rospy.get_namespace()
print("Importing move cmd services...")
print("ns:", ns)

rospy.wait_for_service(ns + 'pose_cmd')
pose_cmd = rospy.ServiceProxy(ns + 'pose_cmd', MoveCmd)

rospy.wait_for_service(ns + 'async_pose_cmd')
async_pose_cmd = rospy.ServiceProxy(ns + 'async_pose_cmd', MoveCmd)

rospy.wait_for_service(ns + 'joint_pose_cmd')
joint_pose_cmd = rospy.ServiceProxy(ns + 'joint_pose_cmd', MoveCmd)

rospy.wait_for_service(ns + 'folding')
fold_cmd = rospy.ServiceProxy(ns + 'folding', MoveCmd)