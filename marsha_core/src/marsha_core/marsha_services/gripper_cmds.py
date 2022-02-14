#!/usr/bin/env python
import rospy

from marsha_msgs.srv import MoveCmd
from std_srvs.srv import Trigger

ns = rospy.get_namespace()

print("Importing left gripper cmd services...")

rospy.wait_for_service(ns + 'gripper/grasp_cmd')
grasp_cmd = rospy.ServiceProxy(ns + 'gripper/grasp_cmd', MoveCmd)

rospy.wait_for_service(ns + 'gripper/is_grasped')
is_grasped = rospy.ServiceProxy(ns + 'gripper/is_grasped', Trigger)