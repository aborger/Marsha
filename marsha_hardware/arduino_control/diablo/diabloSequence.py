#!/usr/bin/env python

###
#
# diabloSequence.py: A script for controlling motors with the Diablo in a sequence.
#
# 2019-04-26
#
###
# Import library functions we need
from __future__ import print_function
from diablo import *
from time import sleep
from sys import exit

# Set up the Diablo
DIABLO = Diablo()        # Create a new Diablo object
DIABLO.Init()                       # Set the board up (checks the board is connected)
if not DIABLO.foundChip:
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
#DIABLO.SetEpoIgnore(True)          # Uncomment to disable EPO latch, needed if you do not have a switch / jumper
DIABLO.ResetEpo()                   # Reset the stop switch (EPO) state
                                    # if you do not have a switch across the two pin header then fit the jumper

# Set our sequence, pairs of motor 1 and motor 2 drive levels
sequence = [
            [+0.2, +0.2],
            [+0.4, +0.4],
            [+0.6, +0.6],
            [+0.8, +0.8],
            [+1.0, +1.0],
            [+0.6, +1.0],
            [+0.2, +1.0],
            [-0.2, +1.0],
            [-0.6, +1.0],
            [-1.0, +1.0],
            [-0.6, +0.6],
            [-0.2, +0.2],
            [+0.2, -0.2],
            [+0.6, -0.6],
            [+1.0, -1.0],
            [+0.6, -0.6],
            [+0.3, -0.3],
            [+0.1, -0.1],
            [+0.0, +0.0],
           ]
stepDelay = 1.0                     # Number of seconds between each sequence step

# Loop over the sequence until the user presses CTRL+C
print ('Press CTRL+C to finish')
try:
    while True:
        # Go through each entry in the sequence in order
        for step in sequence:
            DIABLO.SetMotor1(step[0])               # Set the first motor to the first value in the pair
            DIABLO.SetMotor2(step[1])               # Set the second motor to the second value in the pair
            print ('%+.1f %+.1f' % (step[0], step[1]))
            sleep(stepDelay)                   # Wait between steps
except KeyboardInterrupt:
    # User has pressed CTRL+C
    DIABLO.MotorsOff()              # Turn both motors off
    print ('Done')
