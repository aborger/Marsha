import tkinter as tk
from gui.manual import Manual
from AI.Robot import maneuvers
import threading
from AI.Robot.control import Control
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

        self.maneuver_list = maneuvers.LIST
        list_items = tk.StringVar(value= [x.__name__ for x in self.maneuver_list])
        self.manuevers = tk.Listbox(self, listvariable=list_items)
        self.manuevers.bind('<<ListboxSelect>>', self.maneuver_selection)
        self.client = None

        self.greeting.pack(side="top", fill="x")
        self.toolbar.pack(side="top")
        self.manual.pack(side="left")
        self.connect.pack(side="left")
        self.manuevers.pack(side="left")

        self.protocol("WM_DELETE_WINDOW", self.close_window)
        self.exit_all = False

        self.r = threading.Thread(target=self.run)
        self.r.start()


    def connectCallBack(self):
        self.client = Control()

    def manualCallBack(self):
        manual = Manual(self.client)
        manual.mainloop()




    def run(self):
        while True:
            if self.exit_all:
                break
            if self.client is None:
                # say status not connected
                #print("Not connected")
                time.sleep(1)
            else:
                self.client.get()
                self.client.write()

    def maneuver_selection(self, event):
        index = self.manuevers.curselection()[0]

        if self.client is None:
            print("Not Connected")
        else:
            man = threading.Thread(target=self.maneuver_list[index], args=(self.client,))
            man.start()

    def close_window(self):
        print('Closing')
        try:
            self.client.close()
        except:
            pass
        self.exit_all = True
        self.destroy()


gui = GUI()
gui.mainloop()
