#!/usr/bin/env python

import rospy

from marsha_msgs.srv import PayloadCmd

class PCSstate():
    NA = -1
    GOOD = 0
    STATUS_GOOD = 1
    DISABLED = 2
    SHUTDOWN = 3
    ERROR1 = 4
    ERROR2 = 5
    ERROR3 = 6

class PCScmd():
    PULSE_CHECK = 0
    ACTIVATE = 1
    STATUS = 2
    DEACTIVATE = 3
    SHUTDOWN = 4

class RecState():
    NA = -1
    GOOD = 0
    DISABLE = 1
    ERR_NO_CAMS = 2
    ERR_ONE_CAM = 3
    ERR_RESET_CAMS = 4


# A process or peripheral that can be controlled by the Payload Control System (PCS)
class PCSNode(object):
    def __init__(self, subsystem_name):
        rospy.loginfo("Initializing " + str(subsystem_name))
        rospy.init_node(subsystem_name)
        pcs_nodes = rospy.get_param("/pcs_nodes")
        
        self.pcs_id = pcs_nodes.index(subsystem_name)

        rospy.wait_for_service('payload_cmd')
        self.payload_cmd = rospy.ServiceProxy('payload_cmd', PayloadCmd)

    def pcs_cmd(self, status):
        return self.payload_cmd(self.pcs_id, status)

# A process or peripheral that can be controlled by both arms
class SystemPCSNode(object):
    def __init__(self, subsystem_name):
        rospy.loginfo("Initializing " + subsystem_name)
        rospy.init_node(subsystem_name)
        pcs_nodes = rospy.get_param("/pcs_nodes")

        self.pcs_id = pcs_nodes.index(subsystem_name)

        rospy.wait_for_service('/left/payload_cmd')
        rospy.wait_for_service('/right/payload_cmd')

        self.left_payload_cmd = rospy.ServiceProxy('/left/payload_cmd', PayloadCmd)
        self.right_payload_cmd = rospy.ServiceProxy('/right/payload_cmd', PayloadCmd)

    def l_pcs_cmd(self, status):
        return self.left_payload_cmd(self.pcs_id, status)

    def r_pcs_cmd(self, status):
        return self.right_payload_cmd(self.pcs_id, status)
        

