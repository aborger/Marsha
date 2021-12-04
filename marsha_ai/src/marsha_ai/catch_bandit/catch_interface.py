#!/usr/bin/env python3

import rospy

from marsha_ai.ros_interface import RosInterface

from marsha_msgs.srv import GenerateGrasp
from marsha_msgs.srv import PostureCmd
from marsha_msgs.srv import PredictPosition
from marsha_msgs.srv import GetPos
from marsha_msgs.srv import MoveCmd
from marsha_msgs.srv import PlanGrasp

from std_msgs.msg import Empty

from std_srvs.srv import Trigger, TriggerRequest

from geometry_msgs.msg import Pose

PRE_GRASP_DISTANCE = 2


class CatchInterface(RosInterface):
    def __init__(self):
        super(CatchInterface, self).__init__()

        rospy.wait_for_service('generate_grasp')
        self.generate_grasp = rospy.ServiceProxy('generate_grasp', GenerateGrasp)

        rospy.wait_for_service('/left/posture_cmd')
        self.posture_cmd = rospy.ServiceProxy('/left/posture_cmd', PostureCmd)

        rospy.wait_for_service('/left/plan_grasp')
        self.plan_grasp = rospy.ServiceProxy('/left/plan_grasp', PlanGrasp)

        rospy.wait_for_service('predict_position')
        self.predict_position = rospy.ServiceProxy('predict_position', PredictPosition)

        rospy.wait_for_service('/left/get_pos')
        self.get_pos = rospy.ServiceProxy('/left/get_pos', GetPos)

        rospy.wait_for_service('/left/grasp_cmd')
        self.grasp_cmd = rospy.ServiceProxy('/left/grasp_cmd', MoveCmd)

        rospy.wait_for_service('/left/is_grasped')
        self.is_grasped = rospy.ServiceProxy('/left/is_grasped', Trigger)

        self.reset_pub = rospy.Publisher("/reset", Empty, queue_size=10)

        self.reset_pub.publish()

    # action_space (r, theta, phi, time)
    def perform_action(self, action):

        # Grasp generator takes "tailored latent space" as input
        obj_space_preGrasp = self.generate_grasp(action[0] + PRE_GRASP_DISTANCE, action[1], action[2]).grasp
        obj_space_grasp = self.generate_grasp(action[0], action[1], action[2]).grasp

        # Calculate object position at output time
        print("norm time:", action[3])
        predicted_position = self.predict_position(norm_dist=action[3]).predicted_position
        print("predicted_position:", predicted_position)

        self.grasp_cmd("open")
        pre_grasp = self._object_to_world(obj_space_preGrasp, predicted_position)
        grasp = self._object_to_world(obj_space_grasp, predicted_position)

        success = self.plan_grasp(pre_grasp, grasp).success
        
        print("Plan success: ", success)

        self.grasp_cmd("close")

        catch_success = self.is_grasped().success
        print("catch success: ", catch_success)


        return 0

    def observe(self):
        pass

    def reset_simulation(self):
        print("resetting...")
        self.reset_pub.publish()

    def _object_to_world(self, obj_space, obj_pos):
        world = Pose()
        world.position.x = obj_pos.x + obj_space.position.x
        world.position.y = obj_pos.y + obj_space.position.y
        world.position.z = obj_pos.z + obj_space.position.z
        world.orientation = obj_space.orientation
        return world
