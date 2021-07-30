import tkinter as tk
from gui.manual import Manual
from AI.Robot import states
import threading

import time


WINDOW_SIZE_X = 500
WINDOW_SIZE_Y = 400

class GUI(tk.Tk):
    def __init__(self):
        super().__init__(className=' Marsha Control')
        self.geometry(str(WINDOW_SIZE_X) + "x" + str(WINDOW_SIZE_Y))
        self.greeting = tk.Label(self, text="Welcome to Marsha")
        self.toolbar = tk.Frame(self)
        self.manual = tk.Button(self.toolbar, text="Manual Control", command = self.manualCallBack)
        self.connect = tk.Button(self.toolbar, text="Connect", command=self.connectCallBack)

        list_items = tk.StringVar(value= [x for x in states.Ex])
        self.manuevers = tk.Listbox(self, listvariable=list_items)
        self.manuevers.bind('<<ListboxSelect>>', self.maneuver_selection)

        self.greeting.pack(side="top", fill="x")
        self.toolbar.pack(side="top")
        self.manual.pack(side="left")
        self.connect.pack(side="left")
        self.manuevers.pack(side="left")

        self.protocol("WM_DELETE_WINDOW", self.close_window)
        self.exit_all = False

        self.experts = []
        self.r = threading.Thread(target=self.run)
        self.r.start()



    def connectCallBack(self):
        self.experts.append(states.Expert(False, 0))
        self.experts.append(states.Expert(True, 1))

    def manualCallBack(self):
        for expert in self.experts:
            manual = Manual(expert.control)
            manual.mainloop()


    def run(self):
        while True:
            if self.exit_all:
                break
            if len(self.experts) < 1:
                # say status not connected
                #print("Not connected")
                time.sleep(1)
            else:
                for expert in self.experts:
                    expert.loop()



    def maneuver_selection(self, event):
        index = self.manuevers.curselection()[0]
        for expert in self.experts:
            if expert.is_moving():
                expert.stop()
            if not expert.is_connected:
                print("Not Connected")
            else:
                expert.command = index

    def close_window(self):
        print('Closing')
        try:
            for expert in self.experts:
                expert.close()
        except:
            pass
        self.exit_all = True
        self.destroy()


gui = GUI()
gui.mainloop()
