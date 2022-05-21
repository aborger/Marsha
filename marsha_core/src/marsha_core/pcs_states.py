#!/usr/bin/env python

import rospy
import smach
import smach_ros

from marsha_core.pcs_node import PCSstate
from marsha_core.pcs_node import PCScmd

#from marsha_core.marsha_services.move_cmds import *
#from marsha_core.marsha_services.gripper_cmds import *

# ---------------------------------------------------------------- #
#                              Reload                              #
# ---------------------------------------------------------------- #

class Move_State(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Success', 'Error'])  

# Move state has 'Success' and 'Error' transisitons
class Home(Move_State):

    def execute(self, userdata):
        joint_pose_cmd("home")
        grasp_cmd("close")

        return 'Success'

class Latch(Move_State):

    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("home")
        grasp_cmd("close")

        return 'Success'

class Step_0(Move_State):
    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("folding/step_0")

        return "Success"

class Ball_Status(smach.State):
    def __init__(self, balls_remaining, decrease_balls):
        smach.State.__init__(self, outcomes=['4_Balls', '3_Balls', '2_Balls', '1_Balls', '0_Balls', 'Error'])

        self.balls_remaining = balls_remaining
        self.decrease_balls = decrease_balls

    def execute(self, userdata):
        # left arm goes first
        outcome = str(self.balls_remaining()) + "_Balls"

        self.decrease_balls()

        return outcome

class Catch(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Catch_Success', 'Catch_Fail', 'Error'])

    def execute(self, userdata):
        joint_pose_cmd("pre_throw")
        joint_pose_cmd("throw")
        grasp_cmd("open")
        rospy.sleep(1)
        grasp_cmd("close")

        if is_grasped().success:
            return 'Catch_Success'
        else:
            return 'Catch_Fail'

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
        rospy.sleep(1)
        return 'Success'

class Pickup_1(Move_State):
    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("pre_ball_1")
        joint_pose_cmd("pick_ball_1")
        grasp_cmd("close")
        joint_pose_cmd("pre_ball_1")
        joint_pose_cmd("folding/step_0")

        rospy.sleep(1)

        if is_grasped().success:
            return 'Success'
        else:
            rospy.logwarn("Ball was not picked up!")
            return 'Error'

class Pickup_2(Move_State):
    def execute(self, userdata):
        grasp_cmd("half_closed")
        joint_pose_cmd("pre_ball_2")
        joint_pose_cmd("pick_ball_2")
        grasp_cmd("close")
        joint_pose_cmd("pre_ball_2")
        joint_pose_cmd("folding/step_0")

        rospy.sleep(1)

        if is_grasped().success:
            return 'Success'
        else:
            rospy.logwarn("Ball was not picked up!")
            return 'Error'

class Throw(Move_State):
    def execute(self, userdata):
        joint_pose_cmd("pre_throw")
        #async_joint_pose_cmd("throw")
        rospy.sleep(0.1)
        grasp_cmd("open")
        rospy.sleep(2)
        grasp_cmd("close")

        return 'Success'

# ---------------------------------------------------------------- #
#                         Peripherals                              #
# ---------------------------------------------------------------- #

class PCS_State(smach.State):
    def __init__(self, pcs_node_name=None, pcs_node_state=None, pcs_node_cmd=None, state_comm=None):
        smach.State.__init__(self, outcomes=['Success', 'Error'])

        self.read_state_comm = state_comm
        self.pcs_node_state = pcs_node_state
        self.pcs_node_cmd = pcs_node_cmd

        pcs_nodes = rospy.get_param("/pcs_nodes")
        self.node_id = pcs_nodes.index(pcs_node_name)

class PCS_Activate_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.ACTIVATE)

        while self.pcs_node_state(self.node_id) == PCSstate.NA or self.pcs_node_state(self.node_id) == PCSstate.DISABLED:
            rospy.sleep(0.5)
        
        if self.pcs_node_state(self.node_id) == PCSstate.GOOD:
            return 'Success'
        else:
            return 'Error'

class PCS_Deactivate_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.DEACTIVATE)

        while self.pcs_node_state(self.node_id) == PCSstate.GOOD:
            rospy.sleep(0.5)
        
        if self.pcs_node_state(self.node_id) == PCSstate.DISABLED:
            return 'Success'
        else:
            return 'Error'

class PCS_Shutdown_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.SHUTDOWN)

        while self.pcs_node_state(self.node_id) != PCSstate.SHUTDOWN:
            rospy.sleep(0.5)

        return 'Success'



class Jetson_Comm_Check(smach.State):
    def __init__(self, check_connection):
        smach.State.__init__(self, outcomes=['Success', 'Error'])

        self.check_connection = check_connection

    def execute(self, userdata):
        if self.check_connection():
            rospy.loginfo("Jets Connected!")
            return 'Success'
        else:
            return 'Error'

class Jetson_Sync(smach.State):
    def __init__(self, sync_id, jet_comm, handshake, timeout=10, poll_period=0.1): # timeout in seconds
        smach.State.__init__(self, outcomes=['Ready', 'Timeout'])

        self.sync_id = sync_id
        self.jet_comm = jet_comm
        self.timeout = timeout
        self.poll_period = poll_period
        self.handshake_complete = handshake[0]
        self.reset_handshake_status = handshake[1]
        self.set_sync_id = handshake[2]


    def execute(self, userdata):
        rospy.loginfo("Syncing Jets...")

        time_elapsed = 0
        self.set_sync_id(self.sync_id)

        # waits until other jetson is on the same state
        rospy.loginfo("waiting for state")
        while self.jet_comm().current_state != 'Jetson_Sync_' + str(self.sync_id):
            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                return 'Timeout'
        self.jet_comm().current_state

        # waits until other jetson asks the state
        rospy.loginfo("waiting for handshake")
        while not self.handshake_complete():
            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                return 'Timeout'
        self.jet_comm().current_state
        
        self.reset_handshake_status()

        return 'Ready'


class Teensy_Comm_Check(PCS_Activate_State):
    pass

class Wait_for_TE(PCS_Activate_State):
    pass

class Activate_Longeron_Cams(PCS_Activate_State):
    pass

class Deactivate_Longeron_Cams(PCS_Deactivate_State):
    pass

class Activate_Depth_Cam(PCS_Activate_State):
    pass

class Deactivate_Depth_Cam(PCS_Deactivate_State):
    pass

class Shutdown_Depth_Cam(PCS_Shutdown_State):
    pass