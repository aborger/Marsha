from enum import Enum
import threading
from AI.Robot.control import Control

class Ex(Enum):
    Home_Pos = 0
    Folded_Pos = 1
    Object_Pos = 2
    Pick = 3
    Place = 4
    Pass_Pos = 5
    Pass = 6

class Pos:
    def __init__(self, state, To, From):
        self.To = To
        self.From = From
        self.state = state



class Motion:
    To = 0
    From = 1
    def __init__(self, pos, dir):
        self.position = pos
        self.direction = dir

class MS(Enum):
    SMStart = 1
    Moving = 2
    Waiting = 3

class Fingers(Enum):
    Thumb = 8
    Index = 11
    Middle = 14
    Ring = 17
    Pinky = 20




class Expert:

    def __init__(self, is_reverse, id):
        self.command = Ex.Folded_Pos
        self.state = Ex.Folded_Pos

        self.move_state = MS.SMStart
        self.move_status = MS.Waiting

        self.is_reverse = is_reverse
        self.id = id
        self.control = Control(self.is_reverse, id)


        self.state_machine = {
            Ex.Home_Pos: self.Home,
            Ex.Folded_Pos: self.Folded_Pos,
            Ex.Object_Pos: self.Object_Pos,
            Ex.Pick: self.Pick,
            Ex.Place: self.Place,
            Ex.Pass_Pos: self.Pass_Pos,
            Ex.Pass: self.Pass
        }
        self.move_sm = {
            MS.SMStart: self.MS_SMStart,
            MS.Moving: self.MS_Moving,
            MS.Waiting: self.MS_Waiting
        }


        close_hand = []
        for digit in Fingers:
            for joint in range(0, 3):
                close_hand.append(self.close_finger(digit)[joint])

        open_hand = []
        for digit in Fingers:
            for joint in range(0, 3):
                open_hand.append(self.open_finger(digit)[joint])


        

        self.Folded = Pos(state=Ex.Folded_Pos,
                        To=[(1,0),
                            [(3, 0), (6, 0)],
                            [(4, 0), (5, 0), (7, 0)],
                            (2, 0)],
                        From=[(2, -90),
                            [(4, 150), (5, -180), (7, 130)],
                            [(3, -90), (6, 90)],
                            (1, -90)])

        self.Object = Pos(state=Ex.Object_Pos,
                        To=[[(2, -45), (4, 110), (5, -300)]],
                        From=[[(2, -90), (4, 150), (5, -180)]])

        self.Give = Pos(state=Ex.Pass_Pos,
                        To=([(4, 60)]),
                        From=[(4, 150)])

        self.Pass_object = Pos(state=Ex.Pass,
                            To=([close_hand]), From=())

        self.Pick_up = Pos(state=Ex.Pick, To=([close_hand]), From=())

        self.Place_object = Pos(state=Ex.Pick, To=([open_hand]), From=())

        self.motion = Motion(self.Folded, Motion.To)


    def loop(self):
        self.control.get()
        self.control.write()
        print('state: ', self.state, '|command:', self.command, '|move_state:', self.move_state, '|move status:', self.move_status, '|motion position:', self.motion.position, '|motion direction:', self.motion.direction)
        # Start at beginning command
        if self.command is None: self.command = Ex.Folded_Pos
        self.state_machine[self.state]()
        self.move_sm[self.move_state]()

    def close_finger(self, digit):
        if self.is_reverse:
            return ((digit.value, -90), (digit.value + 1, -45), (digit.value + 2, -45))
        else:
            return ((digit.value, 90), (digit.value + 1, 45), (digit.value + 2, 45))

    def open_finger(self, digit):
        return ((digit.value, 0), (digit.value + 1, 0), (digit.value + 2, 0))

    def stop(self):
        self.control.stop_maneuver()

    def close(self):
        self.control.close()

    def is_connected(self):
        if self.expert.control is None:
            return False
        else:
            return True

        

    def Home(self):
        cmd = Ex(self.command)
        if cmd == Ex.Home_Pos:
            self.move_state = MS.Waiting
        elif cmd == Ex.Folded_Pos:
            self.motion.position = self.Folded
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        elif cmd == Ex.Object_Pos or cmd == Ex.Pick or cmd == Ex.Place:
            self.motion.position = self.Object
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        elif cmd == Ex.Pass_Pos or cmd == Ex.Pass:
            self.motion.position = self.Give
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        else:
            raise ValueError("Command not recognized: " + str(self.command))
        
            
    def is_moving(self):
        if self.move_state == MS.Moving:
            return True
        else:
            return False

    def Folded_Pos(self):
        if Ex(self.command) == Ex.Folded_Pos:
            self.move_state = MS.Waiting
        else:
            self.motion.position = self.Folded
            self.motion.direction = Motion.From
            self.move_state = MS.Moving
        


    def Object_Pos(self):
        if Ex(self.command) == Ex.Object_Pos:
            self.move_state = MS.Waiting
        elif Ex(self.command) == Ex.Pick:
            self.motion.position = self.Pick_up
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        elif Ex(self.command) == Ex.Place:
            self.motion.position = self.Place_object
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        else:
            self.motion.position = self.Object
            self.motion.direction = Motion.From
            self.move_state = MS.Moving

        

    def Pick(self):
        if Ex(self.command) == Ex.Pick:
            self.move_state = MS.Waiting
        else:
            self.motion.position = self.Object
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        

    def Place(self):
        if Ex(self.command) == Ex.Place:
            self.move_state = MS.Waiting
        else:
            self.motion.position = self.Object
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        

    def Pass_Pos(self):
        if Ex(self.command) == Ex.Pass_Pos:
            self.move_state = MS.Waiting
        elif Ex(self.command) == Ex.Pass:
            self.motion.position = self.Pass_object
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        else:
            self.motion.position = self.Give
            self.motion.direction = Motion.From
            self.move_state = MS.Moving
        

    def Pass(self):
        if Ex(self.command) == Ex.Pass:
            self.move_state = MS.Waiting
        else:
            self.motion.position = self.Give
            self.motion.direction = Motion.To
            self.move_state = MS.Moving
        
        



    # ============ Motion States ================

    # States
    def MS_SMStart(self):
        self.move_state = MS.Waiting

    def MS_Moving(self):
        if MS(self.move_status) == MS.SMStart:
            move = threading.Thread(target=self.Start_moving)
            move.start()
            self.move_status == MS.Moving
        elif MS(self.move_status) == MS.Moving:
            pass
        elif MS(self.move_status) == MS.Waiting:
           self.move_state = MS.Waiting
           self.move_status = MS.SMStart



    def Start_moving(self):
        motions = None
        next_state = None
        if self.motion.direction == Motion.To:
            motions = self.motion.position.To
            next_state = self.motion.position.state
        elif self.motion.direction == Motion.From:
            motions = self.motion.position.From
            next_state = Ex.Home_Pos
        else:
            raise ValueError("Motions is invalid: " + str(self.motion.direction))
        for motion in motions:
            self.control.activate(motion)
        self.state = next_state
        self.move_state = MS.Waiting
        self.move_status = MS.Waiting

    def MS_Waiting(self):
        pass
        #self.control.activate(0, 0)