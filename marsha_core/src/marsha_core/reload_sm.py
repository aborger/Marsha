#!/usr/bin/env python

# Reload State Machine

import rospy
import smach
import smach_ros

from marsha_core.pcs_node import PCSstate
from marsha_core.pcs_states import *

from marsha_core.marsha_services.move_cmds import *
from marsha_core.marsha_services.gripper_cmds import *

from marsha_msgs.srv import MoveCmd

# Move state has 'Success' and 'Error' transisitons
class Home(Move_State):

    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("home")
        grasp_cmd("close")

        return 'Success'

class Latch(Move_State):

    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("home")
        grasp_cmd("close")

        return 'Success'

class Step_0(smach.State):
    def __init__(self, self.balls_remaining):
        smach.State.__init__(self, outcomes=['Success', 'Error'])

    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("folding/step_0")

        return 'Success'

class Unfold(Move_State):

    def execute(self, userdata):
        grasp_cmd("close")
        for i in range(0, 9):
            joint_pose_cmd("folding/step_" + str(i))
        
        return 'Success'

class Fold(Move_State):
    def execute(self, userdata):
        grasp_cmd("close")
        for i in range(8, -1, -1):
            joint_pose_cmd("folding/step_" + str(i))
        
        return 'Success'

class Open_Gripper(Move_State):
    def execute(self, userdata):
        grasp_cmd("open")

        return 'Success'

class Pickup_1(Move_State):
    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("pre_ball_1")
        joint_pose_cmd("pick_ball_1")
        grasp_cmd("close")
        joint_pose_cmd("pre_ball_1")
        joint_pose_cmd("folding/step_0")

        return 'Success'

class Pickup_2(Move_State):
    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("pre_ball_2")
        joint_pose_cmd("pick_ball_2")
        grasp_cmd("close")
        joint_pose_cmd("pre_ball_2")
        joint_pose_cmd("folding/step_0")

        return 'Success'



class Reload_SM(object):
    def __init__(self, arm_status):
        self.sm = smach.StateMachine(outcomes=["Out_Of_Balls", "Reload_Fail"])
        

        # both arms work
        if arm_status == PCSstate.GOOD:
            rospy.Service('reload_comm', MoveCmd, self.reload_comm_callback)

            self.balls_remaining = 4

            other_arm = None
            if rospy.get_namespace() == "/left/":
                other_arm = "/right/"
            else:
                other_arm = "/left/"
            """
            rospy.wait_for_service(other_arm + 'pcs_comm')
            self.jet_comm = rospy.ServiceProxy(other_arm + 'pcs_comm', StateComm)
            """

        self.reload_sm()

    def reload_sm(self):
        with self.sm:
            smach.StateMachine.add('Home', Home(),
                                transitions={'Success': 'Step_0',
                                             'Error': 'Reload_Fail'})

            smach.StateMachine.add('Step_0', Step_0(self.balls_remaining),
                                transitions={'Success': 'Pickup_1',
                                             'Error': 'Reload_Fail'})

            smach.StateMachine.add('Pickup_1', Pickup_1(),
                                transitions={'Success': 'Unfold',
                                              'Error': 'Reload_Fail'})

            smach.StateMachine.add('Unfold', Unfold(),
                                transitions={'Success': 'Open_Gripper',
                                             'Error': 'Reload_Fail'})

            smach.StateMachine.add('Open_Gripper', Open_Gripper(),
                                transitions={'Success': 'Fold',
                                             'Error': 'Reload_Fail'})

            smach.StateMachine.add('Fold', Fold(),
                                transitions={'Success': 'Latch',
                                              'Error': 'Reload_Fail'})

            smach.StateMachine.add('Latch', Latch(),
                                transitions={'Success': 'Out_Of_Balls',
                                              'Error': 'Reload_Fail'})


    def reload_comm_callback(self, msg):
        print(msg)

    def reload(self):
        outcome = self.sm.execute()
        print("outcome: " + str(outcome))