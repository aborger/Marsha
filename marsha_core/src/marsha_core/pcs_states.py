#!/usr/bin/env python


import rospy
import smach
import smach_ros
import json

from marsha_core.pcs_node import PCSstate
from marsha_core.pcs_node import PCScmd

from marsha_core.marsha_services.move_cmds import *
from marsha_core.marsha_services.gripper_cmds import *

CATCH_NA = "C_NA"
CATCH_PENDING = "C_PEND"
CATCH_SUCCESS = "C_1"
CATCH_FAIL = "C_0"
# replace with other_arm_ns
other_arm = None
if rospy.get_namespace() == "/left/":
    other_arm = "/right/"
else:
    other_arm = "/left/"


global mission_clock # dict relating rospy time to mission time
global THROW_WINDOWS
THROW_WINDOWS = [122, 142, 162, 182, 202, 222, 242, 262]

CHECKPOINT_DIR = "/home/jet/.marsha/"
CHECKPOINT_FILE = CHECKPOINT_DIR + rospy.get_namespace().replace("/","") + "_sm_checkpoint.log"
# checkpoint dict contains deployed status and number of balls remaining, latched, mission_time
# Only partially implemented. This would allow it to restart from a known state if necessary
def make_checkpoint(deploy_status=None, balls_remaining=None):
    f = open(CHECKPOINT_FILE, "r")
    checkpoint_string = f.read()
    checkpoint_dict = json.loads(checkpoint_string)

    if deploy_status != None:
        checkpoint_dict["deploy_status"] = deploy_status

    if balls_remaining != None:
        checkpoint_dict["balls_remaining"] = balls_remaining

    json_string = json.dumps(checkpoint_dict)
    f = open(CHECKPOINT_FILE, "w")
    f.write(json_string)
    f.close()

# ---------------------------------------------------------------- #
#                      Move State Templates                        #
# ---------------------------------------------------------------- #

class Move_State(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Success', 'Error'])

class Joint_Pose_State(smach.State):
    def __init__(self, pose):
        smach.State.__init__(self, outcomes=['Success', 'Error'])
        self.pose = pose

    def execute(self, userdata):
        complete = False
        try:
            complete = joint_pose_cmd(self.pose).done
        except Exception as e:
            try:
                rospy.logwarn("Joint Pose Cmd Err: " + str(e))
                # try again
                complete = joint_pose_cmd(self.pose).done
            except Exception as e:
                rospy.logwarn("Retrying move failed.")

        if complete:
            return 'Success'
        else:
            return 'Error'

""" 
Joint_Pose_State Example:

    smach.StateMachine.add('Pre_Throw', Joint_Pose_State("pre_throw"),
                        transitions={'Success': 'Jetson_Sync_1',
                                    'Error': 'Ball_Status'})

"""

class Async_Joint_Pose_State(smach.State):
    def __init__(self, pose):
        smach.State.__init__(self, outcomes=['Success', 'Error'])
        self.pose = pose

    def execute(self, userdata):
        complete = async_joint_pose_cmd(self.pose).done

        if complete:
            return 'Success'
        else:
            return 'Error'

class Grasp_Cmd_State(smach.State):
    def __init__(self, pose):
        smach.State.__init__(self, outcomes=['Success', 'Error'])
        self.pose = pose

    def execute(self, userdata):
        complete = grasp_cmd(self.pose).done

        if complete:
            return 'Success'
        else:
            return 'Error'

# wait_time is in seconds
class Wait_State(smach.State):
    def __init__(self, wait_time):
        smach.State.__init__(self, outcomes=['Complete'])
        self.wait_time = wait_time

    def execute(self, userdata):
        rospy.sleep(self.wait_time)

        return 'Complete'


# ---------------------------------------------------------------- #
#                      Jetson Comm States                          #
# ---------------------------------------------------------------- #
# tells other arm, this arm is about to catch
class Signal_Catch(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Done'])

    def execute(self, userdata):
        rospy.set_param('sync_id', CATCH_PENDING)
        return 'Done'

class Check_Catch(smach.State):
    def __init__(self, timeout=20, poll_period=0.5):
        smach.State.__init__(self, outcomes=['Caught', 'Missed', 'Timeout', 'Not_Catching'])

        self.timeout = timeout
        self.poll_period = poll_period

    def execute(self, userdata):
        time_elapsed = 0

        # only so other arm doesnt think this arm is still throwing
        rospy.set_param('sync_id', CATCH_PENDING)

        # waits until other arm has catch feedback
        rospy.loginfo("(JET COMM): Waiting for Catch Status...")
        while rospy.get_param(other_arm + 'sync_id') == CATCH_PENDING:
            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                outcome = 'Timeout'

        catch_status = rospy.get_param(other_arm + 'sync_id')
        if catch_status == CATCH_NA:
            outcome = 'Not_Catching'
        elif catch_status == CATCH_SUCCESS:
            outcome = 'Caught'
        elif catch_status == CATCH_FAIL:
            outcome = 'Missed'
        else:
            rospy.logerr("(JET COMM ERR) Catch status returned: " + str(catch_status))
            outcome = 'Timeout'

        # Reset parameter
        rospy.set_param(other_arm + 'catch_status', CATCH_NA)
        return outcome

        


class Ball_Status(smach.State):
    def __init__(self, other_arm_status=False):
        smach.State.__init__(self, outcomes=['2', '1', '0'])

        self.check_other_arm = other_arm_status

        if self.check_other_arm:
            self.balls_remaining_param = other_arm + 'balls_remaining'
        else:
            self.balls_remaining_param = 'balls_remaining'

    def execute(self, userdata):
        balls_remaining = rospy.get_param(self.balls_remaining_param)
        """
        if not self.check_other_arm:
            make_checkpoint(balls_remaining=balls_remaining)
        """
        if balls_remaining < 0:
            balls_remaining = 0
            


        return str(balls_remaining)



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
    def __init__(self, sync_id, timeout=10, poll_period=0.5): # timeout in seconds
        smach.State.__init__(self, outcomes=['Ready', 'Timeout'])

        self.sync_id = sync_id
        self.timeout = timeout
        self.poll_period = poll_period


    def execute(self, userdata):
        rospy.loginfo("Syncing Jets...")

        time_elapsed = 0
        other_sync_param = other_arm + 'sync_id'

        rospy.set_param('sync_id', self.sync_id)

        # waits until other jetson is on the same state
        rospy.loginfo("(JET COMM): Waiting for Handshake...")

        other_jet_init = False

        while not other_jet_init:
            try:
                rospy.get_param(other_sync_param)
                other_jet_init = True
            except:
                rospy.logwarn("Continuing to wait...")

            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                return 'Timeout'

        while rospy.get_param(other_sync_param) != self.sync_id:
            other_jet_init = True
            # debug
            #rospy.loginfo("ID: " + str(self.sync_id) + " other ID: " + str(rospy.get_param(other_sync_param)))
            # add something to detect if self.jet_comm() returns False which indicates it cannot communicate with other jetson
            rospy.sleep(self.poll_period)
            time_elapsed += self.poll_period
            if time_elapsed > self.timeout:
                return 'Timeout'


        return 'Ready'

# Done after throwing to keep other arm on same state
class Reduce_Balls(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Done'])

    def execute(self, userdata):
        balls_remaining = rospy.get_param('balls_remaining')
        rospy.set_param('balls_remaining', balls_remaining-1)

        return 'Done'

class Set_Mission_Clock(smach.State):
    def __init__(self, mission_time):
        smach.State.__init__(self, outcomes=['Done'])
        self.mission_time = mission_time

    def execute(self, userdata):
        global mission_clock 
        mission_clock = {'ros': rospy.get_time(), 'mission': self.mission_time}

        return 'Done'

class Wait_For_Mission_Clock(smach.State):
    def __init__(self, mission_time):
        smach.State.__init__(self, outcomes=['Done'])
        self.mission_time = mission_time

    def execute(self, userdata):
        global mission_clock
        # seconds between mission milestone and desired mission time + rospy time at mission milestone
        future_rospy_seconds = (self.mission_time - mission_clock['mission']) + mission_clock['ros']
        future_rospy_time = rospy.Time.from_sec(future_rospy_seconds)
        time_until = future_rospy_time - rospy.get_rostime()

        rospy.sleep(time_until)
        return 'Done'

class Check_for_Spinup(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Spinup', 'no_spinup'])

    def execute(self, userdata):
        global mission_clock
        spinup_time=307


        time_since_te = rospy.get_time() - mission_clock['ros']
        mission_time = mission_clock['mission'] + time_since_te
        time_until_spinup = spinup_time - mission_time
        if time_until_spinup < 0:
          rospy.set_param('/mission_complete', True)
          return 'Spinup'
        else:
          return 'no_spinup'

class Wait_for_Throw_Window(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Done', 'Out_Of_Windows'])
        
    def execute(self, userdata):
        global mission_clock
        global THROW_WINDOWS

        current_mission_time = rospy.get_time() - mission_clock['ros'] + mission_clock['mission']
        rospy.loginfo("Current Mission Time: T+" + str(current_mission_time))

        desired_mission_time = -1
        # Throw windows is a list from earliest to latest window
        # Get the first window that has not passed yet
        for window_time in THROW_WINDOWS:
            if current_mission_time < window_time:
                # wait until this window
                desired_mission_time = window_time
                break

        if desired_mission_time == -1:
            return 'Out_Of_Windows'
        else:
            rospy.loginfo("Waiting until T+" + str(desired_mission_time))
            future_rospy_seconds = (desired_mission_time - mission_clock['mission']) + mission_clock['ros']
            future_rospy_time = rospy.Time.from_sec(future_rospy_seconds)
            time_until = future_rospy_time - rospy.get_rostime()

            rospy.sleep(time_until)
            return 'Done'




# ---------------------------------------------------------------- #
#                           Complex Moves                          #
# ---------------------------------------------------------------- #
# Note: These are not really used any more
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

class Catch(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Success', 'Fail'])

    def execute(self, userdata):
        rospy.set_param('sync_id', CATCH_PENDING)
        rospy.sleep(0.75)
        grasp_cmd("close")

        rospy.sleep(1)

        # this is replaced with is_grasped()
        if False:
            rospy.set_param('sync_id', CATCH_SUCCESS)
            return 'Success'
        else:
            rospy.set_param('sync_id', CATCH_FAIL)
            return 'Fail'

class Is_Grasped(smach.State):
    def __init__(self):
        smach.State.__init__(self, outcomes=['Success', 'Fail'])

    def execute(self, userdata):
        if False: #is_grasped():
            rospy.set_param('sync_id', CATCH_SUCCESS)
            rospy.sleep(1) # wait for signal to be recieved
            return 'Success'
        else:
            rospy.set_param('sync_id', CATCH_FAIL)
            rospy.sleep(1) # wait for signal to be recieved
            return 'Fail'


class Open_Gripper(Move_State):
    def execute(self, userdata):
        grasp_cmd("open")
        rospy.sleep(1)
        return 'Success'

# should move to state machine
class Pickup_1(Move_State):
    def execute(self, userdata):
        try:
            grasp_cmd("half_closed")
            joint_pose_cmd("pre_ball_1")
            joint_pose_cmd("pick_ball_1")
            grasp_cmd("grasp_mount")
            rospy.sleep(2)
            joint_pose_cmd("pre_ball_1")
            joint_pose_cmd("folding/step_1")
        except Exception as e:
            rospy.logwarn("Retrying move failed.")
            return 'Error'

        rospy.sleep(1)

        if is_grasped().success:
            return 'Success'
        else:
            rospy.logwarn("Ball was not picked up!")
            return 'Error'


# should move to state machine
class Pickup_2(Move_State):
    def execute(self, userdata):
        try:
            grasp_cmd("half_closed")
            joint_pose_cmd("pre_ball_2")
            joint_pose_cmd("pick_ball_2")
            grasp_cmd("grasp_mount")
            rospy.sleep(1)
            joint_pose_cmd("pre_ball_2")
            joint_pose_cmd("folding/step_1")
        except Exception as e:
            rospy.logwarn("Retrying move failed.")
            return 'Error'

        rospy.sleep(1)

        if is_grasped().success:
            return 'Success'
        else:
            rospy.logwarn("Ball was not picked up!")
            return 'Error'







# ---------------------------------------------------------------- #
#                      Maneuver State Machines                     #
# ---------------------------------------------------------------- #

NUM_FOLDING_STEPS = 4

# ================================================================ #


Unfold_SM = smach.StateMachine(outcomes=["Success", "Fail"])

with Unfold_SM:

    smach.StateMachine.add('step_0', Joint_Pose_State("folding/step_0"),
                            transitions={'Success': 'step_1',
                                        'Error': 'step_1'})

    smach.StateMachine.add('step_1', Joint_Pose_State("folding/step_1"),
                            transitions={'Success': 'close_gripper',
                                        'Error': 'close_gripper'})


    smach.StateMachine.add('close_gripper', Grasp_Cmd_State("close"),
                        transitions={'Success': 'step_2',
                                        'Error': 'step_2'})

    smach.StateMachine.add('step_2', Joint_Pose_State("folding/step_2"),
                            transitions={'Success': 'step_3',
                                        'Error': 'step_3'})

    smach.StateMachine.add('step_3', Joint_Pose_State("folding/step_3"),
                            transitions={'Success': 'step_4',
                                        'Error': 'step_4'})

    smach.StateMachine.add('step_4', Joint_Pose_State("folding/step_4"),
                            transitions={'Success': 'Success',
                                        'Error': 'Success'})




# ================================================================ #

Fold_SM = smach.StateMachine(outcomes=["Success", "Fail"])

with Fold_SM:


    smach.StateMachine.add('Close_Gripper', Grasp_Cmd_State("close"),
                        transitions={'Success': 'step_4',
                                     'Error': 'step_4'})

    smach.StateMachine.add('step_4', Joint_Pose_State("folding/step_4"),
                            transitions={'Success': 'step_3',
                                        'Error': 'step_3'})

    smach.StateMachine.add('step_3', Joint_Pose_State("folding/step_3"),
                        transitions={'Success': 'step_2',
                                    'Error': 'step_2'})

    smach.StateMachine.add('step_2', Joint_Pose_State("folding/step_2"),
                        transitions={'Success': 'step_1',
                                    'Error': 'step_1'})

    smach.StateMachine.add('step_1', Joint_Pose_State("folding/step_1"),
                    transitions={'Success': 'Success',
                                'Error': 'Fail'})




# ================================================================ #
Catch_SM = smach.StateMachine(outcomes=["Catch_Success", "Catch_Fail"])

with Catch_SM:
    """
    smach.StateMachine.add('Pre_Catch', Joint_Pose_State("pre_catch"),
                        transitions={'Success': 'Open_Gripper',
                                     'Error': 'Catch_Fail'})
    """
    smach.StateMachine.add('Open_Gripper', Grasp_Cmd_State("open"),
                        transitions={'Success': 'Jetson_Sync_Pass',
                                     'Error': 'Catch_Fail'})
                        
    smach.StateMachine.add('Jetson_Sync_Pass', Jetson_Sync("pass", timeout=30),
                        transitions={'Ready': 'Ready_Catch',
                                     'Timeout': 'Catch_Fail'})
    """
    smach.StateMachine.add('Ready_Catch', Joint_Pose_State("catch"),
                        transitions={'Success': 'Catch',
                                     'Error': 'Catch_Fail'})
    """

    smach.StateMachine.add('Ready_Catch', Grasp_Cmd_State("half_closed"),
                    transitions={'Success': 'Catch',
                                    'Error': 'Catch_Fail'})

    smach.StateMachine.add('Catch', Catch(),
                        transitions={'Success': 'Success_Wait',
                                     'Fail': 'Fail_Wait'})

    smach.StateMachine.add('Success_Wait', Wait_State(5),
                        transitions={'Complete': 'Catch_Success'})


    smach.StateMachine.add('Fail_Wait', Wait_State(5),
                        transitions={'Complete': 'Catch_Fail'})

# ================================================================ #

Reload_SM = smach.StateMachine(outcomes=["Success", "Out_Of_Balls", "Fail"])

with Reload_SM:
    # Assumes already folded

    smach.StateMachine.add('Ball_Status', Ball_Status(),
                        transitions={'2': 'Pickup_1',
                                     '1': 'Pickup_2',
                                     '0': 'Out_Of_Balls'})    

    # Should try to pick it up again
    smach.StateMachine.add('Pickup_1', Pickup_1(),
                        transitions={'Success': 'Unfold',
                                     'Error': 'Unfold'})

    smach.StateMachine.add('Pickup_2', Pickup_2(),
                        transitions={'Success': 'Unfold',
                                     'Error': 'Out_Of_Balls'})

    smach.StateMachine.add('Unfold', Unfold_SM,
                        transitions={'Success': 'Success',
                                    'Fail': 'Fail'})


# ================================================================ #


Throw_SM = smach.StateMachine(outcomes=["Pass_Complete", "Throw_Success", "Throw_Fail"])

with Throw_SM:

    
    smach.StateMachine.add('Pre_Throw', Joint_Pose_State("pre_throw"),
                        transitions={'Success': 'Jetson_Sync_Pass',
                                    'Error': 'Jetson_Sync_Pass'})
    """
    smach.StateMachine.add('Wait_for_Throw_Window', Wait_for_Throw_Window(),
                        transitions={'Done': 'Jetson_Sync_Pass',
                                     'Out_Of_Windows': 'Throw_Fail'})
    """
    
    # Attempt to catch if this sync times out
    smach.StateMachine.add('Jetson_Sync_Pass', Jetson_Sync("pass"),
                        transitions={'Ready': 'Wait_to_Throw',
                                    'Timeout': 'Throw_Fail'})
    
    smach.StateMachine.add('Wait_to_Throw', Wait_State(1),
                        transitions={'Complete': 'Throw'})
    
    
    smach.StateMachine.add('Throw', Async_Joint_Pose_State("throw"),
                        transitions={'Success': 'Wait_to_Release',
                                    'Error': 'Wait_to_Release'})
    

    smach.StateMachine.add('Wait_to_Release', Wait_State(0.2),
                        transitions={'Complete': 'Release'})

    smach.StateMachine.add('Release', Grasp_Cmd_State("open"),
                        transitions={'Success': 'Reduce_Balls',
                                    'Error': 'Throw_Fail'})

    smach.StateMachine.add('Reduce_Balls', Reduce_Balls(),
                        transitions={'Done': 'Check_Catch'})
    
    smach.StateMachine.add('Check_Catch', Check_Catch(timeout=30),
                        transitions={'Caught': 'Pass_Complete',
                                      'Missed': 'Throw_Success',
                                      'Timeout': 'Throw_Success',
                                      'Not_Catching': 'Throw_Fail'})
    



# ---------------------------------------------------------------- #
#                         Peripherals                              #
# ---------------------------------------------------------------- #

class PCS_State(smach.State):
    def __init__(self, pcs_node_name=None, pcs_node_state=None, pcs_node_cmd=None, state_comm=None):
        smach.State.__init__(self, outcomes=['Success', 'Error'])

        self.read_state_comm = state_comm
        self.pcs_node_state = pcs_node_state
        self.pcs_node_cmd = pcs_node_cmd

        self.pcs_nodes = rospy.get_param("/pcs_nodes")
        self.node_id = self.pcs_nodes.index(pcs_node_name)

class PCS_Activate_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.ACTIVATE)

        while self.pcs_node_state(self.node_id) == PCSstate.NA or self.pcs_node_state(self.node_id) == PCSstate.DISABLED:
            rospy.sleep(0.5)
        
        if self.pcs_node_state(self.node_id) == PCSstate.GOOD:
            return 'Success'
        else:
            return 'Error'

class Blink_LED(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.STATUS)

        while self.pcs_node_state(self.node_id) == PCSstate.NA or self.pcs_node_state(self.node_id) == PCSstate.DISABLED:
            rospy.sleep(0.5)
        
        if self.pcs_node_state(self.node_id) == PCSstate.GOOD:
            return 'Success'
        else:
            return 'Error'



class Check_RBF_Status(PCS_State):
    def __init__(self, pcs_node_name=None, pcs_node_state=None, pcs_node_cmd=None, state_comm=None):
        smach.State.__init__(self, outcomes=['Enabled', 'Disabled'])

        self.read_state_comm = state_comm
        self.pcs_node_state = pcs_node_state
        self.pcs_node_cmd = pcs_node_cmd

        self.pcs_nodes = rospy.get_param("/pcs_nodes")
        self.node_id = self.pcs_nodes.index(pcs_node_name)

    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.ACTIVATE)

        while self.pcs_node_state(self.node_id) == PCSstate.NA:
            rospy.sleep(0.5)
        
        if self.pcs_node_state(self.node_id) == PCSstate.GOOD:
            return 'Enabled'
        else:
            return 'Disabled'


class PCS_Pulse_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.PULSE_CHECK)

        while self.pcs_node_state(self.node_id) == PCSstate.NA or self.pcs_node_state(self.node_id) == PCSstate.DISABLED:
            rospy.sleep(1)
        
        if self.pcs_node_state(self.node_id) == PCSstate.GOOD:
            return 'Success'
        else:
            return 'Error'

# pretty much the same as activate and pulse state, but allows for different proceed signal
class PCS_Feedback_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.STATUS)

        time_elapsed = 0
        poll_period = 0.5
        timeout = 10

        while self.pcs_node_state(self.node_id) != PCSstate.STATUS_GOOD or self.pcs_node_state(self.node_id) != PCSstate.DISABLED:
            rospy.sleep(0.5)
            time_elapsed += poll_period
            if time_elapsed > timeout:
                return 'Error'

        
        if self.pcs_node_state(self.node_id) == PCSstate.STATUS_GOOD:
            return 'Success'
        else:
            return 'Error'

class PCS_Deactivate_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.DEACTIVATE)

        while self.pcs_node_state(self.node_id) != PCSstate.DISABLED:
            rospy.loginfo("Deactivating node: " + str(self.pcs_nodes[self.node_id]) + " Node State: " + str(self.pcs_node_state(self.node_id)))
            rospy.sleep(0.5)

        return 'Success'


class PCS_Shutdown_State(PCS_State):
    def execute(self, userdata):
        self.pcs_node_cmd(self.node_id, PCScmd.SHUTDOWN)

        while self.pcs_node_state(self.node_id) != PCSstate.SHUTDOWN:
            rospy.sleep(0.5)

        return 'Success'


# These are kind of unneccessary they just rename their parent states


class Teensy_Comm_Check(PCS_Activate_State):
    pass

class Wait_for_TE(PCS_Activate_State):
    pass




class Wait_for_AI(PCS_Pulse_State):
    pass

class Activate_AI(PCS_Activate_State):
    pass

class AI_Catch_Status(PCS_Feedback_State):
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



class Activate_Led(PCS_Activate_State):
    pass

class Deactivate_Led(PCS_Deactivate_State):
    pass
