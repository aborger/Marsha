import tkinter as tk
import threading

WINDOW_SIZE_X = 500
WINDOW_SIZE_Y = 200

class Manual(tk.Tk):
    def __init__(self, client):
        super().__init__(className=' Manual Mode')
        self.client = client
        self.geometry(str(WINDOW_SIZE_X) + "x" + str(WINDOW_SIZE_Y))
        self.joint_frame = tk.Frame(self)
        self.joint_label = tk.Label(self.joint_frame, text = "Joint Number")
        self.joint_text = tk.Text(self.joint_frame, height = 2, width = 32)
        self.joint_text.tag_configure("center", justify="center")
        self.joint_text.insert("1.0", " ", "center")
        self.angle_frame = tk.Frame(self)
        self.angle_label = tk.Label(self.angle_frame, text="Angle Value")
        self.angle_text = tk.Text(self.angle_frame, height= 2, width=32)
        self.angle_text.tag_configure("center", justify="center")
        self.angle_text.insert("1.0", " ", "center")
        self.go_button = tk.Button(self, text="Go", command=self.goCallBack)

        self.go_button.pack(side="bottom", fill="x")
        self.joint_frame.pack(side="left")
        self.joint_label.pack(side="top")
        self.joint_text.pack(side="top")
        self.angle_frame.pack(side="right")
        self.angle_label.pack(side="top")
        self.angle_text.pack(side="top")
        

    def goCallBack(self):
        def go():
            self.client.activate(joint, angle)
        try:
            joint = int(self.joint_text.get("1.0", tk.END))
            angle = int(self.angle_text.get("1.0", tk.END))
        except ValueError:
            print("Not a valid number.")
        if self.client is None:
            print('Not Connected')
        else:
            man = threading.Thread(target=go)
            man.start()

