#!/usr/bin/env python

###
#
# diabloGui.py: A GUI for controlling motors with the Diablo.
#
# 2019-04-26
#
###

# Import library functions we need
from __future__ import print_function
from diablo import *
from sys import exit
try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk


# Set up the Diablo
global DIABLO
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
                                    # If you do not have a switch across the two pin header then fit the jumper

# Class representing the GUI dialog
class Diablo_tk(tk.Tk):
    # Constructor (called when the object is first created)
    def __init__(self, parent):
        tk.Tk.__init__(self, parent)
        self.parent = parent
        self.protocol("WM_DELETE_WINDOW", self.OnExit) # Call the OnExit function when user closes the dialog
        self.Initialise()

    # Initialise the dialog
    def Initialise(self):
        global DIABLO
        self.title('Diablo Example GUI')
        # Set up a grid of 2 sliders which command each motor output, plus a stop button for both motors
        self.grid()
        self.sld1 = tk.Scale(self, from_ = +100, to = -100, orient = tk.VERTICAL, command = self.sld1_move)
        self.sld1.set(0)
        self.sld1.grid(column = 0, row = 0, rowspan = 1, columnspan = 1, sticky = 'NSEW')
        self.sld2 = tk.Scale(self, from_ = +100, to = -100, orient = tk.VERTICAL, command = self.sld2_move)
        self.sld2.set(0)
        self.sld2.grid(column = 1, row = 0, rowspan = 1, columnspan = 1, sticky = 'NSEW')
        self.butOff = tk.Button(self, text = 'All Off', command = self.butOff_click)
        self.butOff['font'] = ("Arial", 20, "bold")
        self.butOff.grid(column = 0, row = 1, rowspan = 1, columnspan = 2, sticky = 'NSEW')
        self.grid_columnconfigure(0, weight = 1)
        self.grid_columnconfigure(1, weight = 1)
        self.grid_rowconfigure(0, weight = 4)
        self.grid_rowconfigure(1, weight = 1)
        # Set the size of the dialog
        self.resizable(True, True)
        self.geometry('200x600')
        # Set up the initial motor state
        DIABLO.MotorsOff()

    # Called when the user closes the dialog
    def OnExit(self):
        global DIABLO
        # Turn drives off and end the program
        DIABLO.MotorsOff()
        self.quit()

    # Called when sld1 is moved
    def sld1_move(self, value):
        global DIABLO
        DIABLO.SetMotor1(float(value) / 100.0)

    # Called when sld2 is moved
    def sld2_move(self, value):
        global DIABLO
        DIABLO.SetMotor2(float(value) / 100.0)

    # Called when butOff is clicked
    def butOff_click(self):
        global DIABLO
        DIABLO.MotorsOff()
        self.sld1.set(0)
        self.sld2.set(0)

# if we are the main program (python was passed a script) load the dialog automatically
if __name__ == "__main__":
    app = Diablo_tk(None)
    app.mainloop()
