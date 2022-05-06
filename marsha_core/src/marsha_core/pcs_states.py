#!/usr/bin/env python

import rospy
import smach
import smach_ros

from marsha_core.pcs_node import PCSstate
from marsha_core.pcs_node import PCScmd

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

        while self.pcs_node_state(self.node_id) == PCSstate.NA:
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
        self.read_jet_comm = jet_comm
        self.timeout = timeout
        self.poll_period = poll_period
        self.handshake_complete = handshake[0]
        self.reset_handshake_status = handshake[1]


    def execute(self, userdata):
        rospy.loginfo("Syncing Jets...")

        time_elapsed = 0

        # waits until other jetson is on the same state
        while self.read_jet_comm().current_state != 'Jetson_Sync_' + str(self.sync_id):
            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                return 'Timeout'

        # waits until other jetson asks the state
        while not self.handshake_complete():
            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                return 'Timeout'
        
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