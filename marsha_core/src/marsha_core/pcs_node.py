#!/usr/bin/env python

import rospy

from marsha_msgs.srv import PayloadCmd

class PCSstate():
    NA = -1
    GOOD = 0
    DISABLED = 1
    ERROR1 = 2
    ERROR2 = 3

class PCScmd():
    ACTIVATE = 1
    DEACTIVATE = 2
    SHUTDOWN = 3


class PCSNode(object):
    def __init__(self, subsystem_name):
        print("initializing")
        print(subsystem_name)
        rospy.init_node(subsystem_name)
        pcs_nodes = rospy.get_param("/pcs_nodes")
        
        self.pcs_id = pcs_nodes.index(subsystem_name)

        rospy.wait_for_service('payload_cmd')
        self.payload_cmd = rospy.ServiceProxy('payload_cmd', PayloadCmd)

    def pcs_cmd(self, error):
        return self.payload_cmd(self.pcs_id, error)