from enum import Enum
import threading

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


class Expert:
    def __init__(self, control):
        self.command = Ex.Folded_Pos
        self.state = Ex.Folded_Pos


        self.move_state = MS.SMStart
        self.move_status = MS.Waiting
        self.control = control

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

        self.Folded = Pos(state=Ex.Folded_Pos,
                        To=[(8,0),
                            (10, 0),
                            [(11, 0), (12, 0), (14, 0)],
                            (9, 0)],
                        From=[(9, -90),
                            [(11, -180), (12, -180), (14, -180)],
                            (10, -90),
                            (8, 110)])

        self.Object = Pos(state=Ex.Object_Pos,
                        To=[[(9, -45), (11, -110), (12, -300)]],
                        From=[[(9, -90), (11, -180), (12, -180)]])

        self.Give = Pos(state=Ex.Pass_Pos,
                        To=[(11, -90)],
                        From=[(11, -180)])

        self.motion = Motion(self.Folded, Motion.To)



        

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
            self.state = Ex.Pick
        elif Ex(self.command) == Ex.Place:
            self.state = Ex.Place
        else:
            self.motion.position = self.Object
            self.motion.direction = Motion.From
            self.move_state = MS.Moving
        

    def Pick(self):
        print("Picking...")
        self.state = Ex.Object_Pos
        

    def Place(self):
        print("Placing")
        self.state = Ex.Object_Pos
        

    def Pass_Pos(self):
        if Ex(self.command) == Ex.Pass_Pos:
            self.move_state = MS.Waiting
        elif Ex(self.command) == Ex.Pass:
            self.state = Ex.Pass
        else:
            self.motion.position = self.Give
            self.motion.direction = Motion.From
            self.move_state = MS.Moving
        

    def Pass(self):
        print("Passing")
        self.state = Ex.Pass_Pos
        
        



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