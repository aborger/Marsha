#!/usr/bin/env python

# Unfortunately the AR3 has one stepper that requires a current higher than the big easy controllers can produce.

# A diablo motor controller is being used instead.

# This file replicates the Arduino Stepper class library written by Aaron, but for the diablo which was also unfortunately features drivers written in python.

# It is based on the diabloStepper.py example at https://github.com/piborg/diablo/blob/master/diabloStepper.py

# Author: Aaron Borger unfortunately...

from diablo import *
from time import sleep


DRIVE_LEVEL = 1.0
HOLD_LEVEL = 0.0
TOLERANCE = 1


class Stepper:
    def __init__(self, voltageIn, stepperCurrent, stepperResistance):

        self.stepDelay = 0.01 # Default, can be changed with set_speed()
        self.seq_step = -1

        self.current_step = 0
        self.desired_step = 0
        

        voltageOut = float(stepperCurrent) * float(stepperResistance)
        stepperPower = voltageOut / float(voltageIn)
        maxPower = DRIVE_LEVEL * stepperPower
        holdingPower = HOLD_LEVEL * stepperPower

        self.sequence = [                            # Order for stepping
                    [+maxPower, +maxPower],
                    [+maxPower, -maxPower],
                    [-maxPower, -maxPower],
                    [-maxPower, +maxPower]] 
        self.sequenceHold = [                        # Order for stepping at holding power
                    [+holdingPower, +holdingPower],
                    [+holdingPower, -holdingPower],
                    [-holdingPower, -holdingPower],
                    [-holdingPower, +holdingPower]]

        self.DIABLO = Diablo()
        #DIABLO.i2cAddress = 0x44                # Uncomment and change the value if you have changed the board address
        self.DIABLO.Init()
        if not self.DIABLO.foundChip:
            boards = ScanForDiablo()
            if len(boards) == 0:
                print('No Diablo found, check you are attached :)')
            else:
                print('No Diablo at address %02X, but we did find boards:' % (DIABLO.i2cAddress))
                for board in boards:
                    print('    %02X (%d)' % (board, board))
                print('If you need to change the I2C address change the set-up line so it is correct, e.g.')
                print('DIABLO.i2cAddress = 0x%02X' % (boards[0]))
            exit()
        #DIABLO.SetEpoIgnore(True)              # Uncomment to disable EPO latch, needed if you do not have a switch / jumper
        self.DIABLO.ResetEpo()

    def set_point(self, step_position):
        self.desired_step = step_position
    
    def get_current_step(self):
        return self.current_step


    def move(self, num_steps):
        self.desired_step = self.current_step + num_steps
        while (self.desired_step != self.current_step):
            self.step()
        

    def step(self):
        error = self.desired_step - self.current_step
        if error < TOLERANCE and error > TOLERANCE * -1:
            self.HoldPosition()
        else:
            print("Desired: ", self.desired_step, " Current: ", self.current_step, " Error: ", error)
            # Choose direction based on sign (+/-)
            if error < 0:
                dir = -1
                error *= -1
            else:
                dir = 1

            # Set a starting position if this is the first move
            if self.seq_step == -1:
                drive = self.sequence[-1]
                self.DIABLO.SetMotor1(drive[0])
                self.DIABLO.SetMotor2(drive[1])
                self.seq_step = 0
            else:
                self.seq_step += dir

            # Wrap step when we reach the end of the sequence
            if self.seq_step < 0:
                self.seq_step = len(self.sequence) - 1
            elif self.seq_step >= len(self.sequence):
                self.seq_step = 0

            # For this step set the required drive values
            if self.seq_step < len(self.sequence):
                drive = self.sequence[self.seq_step]
                self.DIABLO.SetMotor1(drive[0])
                self.DIABLO.SetMotor2(drive[1])
            sleep(self.stepDelay)
            self.current_step += dir

    # Function to switch to holding power
    def HoldPosition(self):
        # For the current step set the required holding drive values
        if self.seq_step < len(self.sequence):
            drive = self.sequenceHold[self.seq_step]
            self.DIABLO.SetMotor1(drive[0])
            self.DIABLO.SetMotor2(drive[1])

