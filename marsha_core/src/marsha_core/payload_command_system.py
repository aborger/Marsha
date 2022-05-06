#!/usr/bin/env python

# Payload Control System

import rospy
import smach
import smach_ros

#from marsha_core.marsha_services.move_cmds import *
#from marsha_core.marsha_services.gripper_cmds import *

from marsha_core.pcs_node import PCSstate
from marsha_core.pcs_node import PCScmd
from marsha_core.pcs_states import *

import os
import serial
from subprocess import Popen, PIPE, STDOUT

from marsha_msgs.srv import StateComm
from marsha_msgs.srv import PayloadCmd

NUM_CONNECTION_ATTEMPTS = 3

# Used to check jetson power
#os.system("sudo chmod 777 /sys/bus/i2c/drivers/ina3221x/6-0040/iio:device0/in_voltage1_input")

def jets_connected():
    other_jet = "jet"
    this_jet = "marsha"
    p = Popen('ping ' + other_jet, stdout=PIPE, stderr = STDOUT, shell=True)

    num_attempts = 0
    num_connections = 0
    first_line = p.stdout.readline()
    while num_attempts < NUM_CONNECTION_ATTEMPTS:
        line = p.stdout.readline()
        beginning = line.split("(")[0]

        if beginning == "64 bytes from " + other_jet + " ":
            num_connections += 1
        elif beginning == "From " + this_jet + " ":
            pass
        else:
            rospy.logwarn(line)


        num_attempts += 1
    if num_connections == NUM_CONNECTION_ATTEMPTS:
        return True
    else:
        return False

def teensy_connected():
    """
    Find way to test teensy connection!
    os.system("sudo chmod -R 777 /dev/ttyTHS1")
    try:
        arduino = serial.Serial(
            port = '/dev/ttyTHS1',
            baudrate = 115200,
            bytesize = serial.EIGHTBITS,
            parity = serial.PARITY_NONE,
            stopbits = serial.STOPBITS_ONE,
            timeout = 5,
            xonxoff = False,
            rtscts = False,
            dsrdtr = False,
            writeTimeout = 2
        )
        print(arduino.write(" "))
    except Exception as e:
        print(e)
    """
    return True

def power_consumption():

    f = open("/sys/bus/i2c/drivers/ina3221x/6-0040/iio:device0/in_voltage1_input", "r")
    voltage = f.read()
    f.close()
    print(voltage)



# ---------------------------------------------------------------- #
#                       State Machine                              #
# ---------------------------------------------------------------- #

class PCS_SM(object):
    def __init__(self):

        self.stateComm = rospy.Service('pcs_comm', StateComm, self.state_comm_callback)

        # ensures both jetsons are on the same sync state
        self.curr_sync_id = 0
        self.handshake_status = False


        self.sm = smach.StateMachine(outcomes=["Mission_Success", "Mission_Fail"])

        rospy.Service('payload_cmd', PayloadCmd, self.payload_cmd_cb)

        pcs_nodes = rospy.get_param("/pcs_nodes")

        # this list contains the state for each node
        # access a node's state with self.pcs_nodes[node_id]
        self.pcs_node_states = [-1] * len(pcs_nodes)
        self.pcs_node_cmds = [-1] * len(pcs_nodes)


        other_arm = None
        if rospy.get_namespace() == "/left/":
            other_arm = "/right/"
        else:
            other_arm = "/left/"

        self.jet_connection = jets_connected()

        # Note: This needs to be done after comm check
        rospy.loginfo('Waiting for service...')
        if self.jet_connection:
            rospy.wait_for_service(other_arm + 'pcs_comm')
            self.jet_comm = rospy.ServiceProxy(other_arm + 'pcs_comm', StateComm)

        self.mission_sm()
        self.handshake = (self.get_handshake_status, self.reset_handshake, self.set_sync_id)

    def connection_status(self):
        return self.jet_connection

    def state_comm_callback(self, req):
        states = self.sm.get_active_states()
        if states[0] == 'Jetson_Sync_' + str(self.curr_sync_id):
            self.handshake_status = True

        return states[0]

    def get_handshake_status(self):
        return self.handshake_status

    def set_sync_id(self, id):
        self.curr_sync_id = id

    def reset_handshake(self):
        self.handshake_status = False

    def payload_cmd_cb(self, msg):
        rospy.logdebug("From: " + str(msg.pcs_id) + " Msg: " + str(msg.state))

        self.pcs_node_states[msg.pcs_id] = msg.state

        return self.pcs_node_cmds[msg.pcs_id]

    def pcs_node_state(self, node_id):
        return self.pcs_node_states[node_id]

    def pcs_node_cmd(self, node_id, cmd):
        self.pcs_node_cmds[node_id] = cmd


    def mission_sm(self):
        pass

    

    def run(self):
        outcome = self.sm.execute()
