from AI.server import Server
import threading


class Control:
    def __init__(self):
        self.server = Server()
        self.actions = [0] * 15
        self.observations = []

    def write(self):
        json = {"actions": self.actions}
        self.server.write(json)

    def get(self):
        try:
            self.observations = self.server.read()['positions']
            print(self.observations)
        except:
            pass
        

    def individual_activate(self, joint, angle):
        error = angle - self.observations[joint]
        self.actions[joint] = error
        self.write()

    def deactivate(self, joint):
        self.actions[joint] = 0

    def wait_for_position(self, joint, angle):
        BUFFER = 1
        while True:
            self.get()
            self.write()
            if self.observations[joint] < angle + BUFFER and self.observations[joint] > angle - BUFFER:
                self.actions[joint] = 0
                break

    def activate(self, *args):
        # A list of commands was passed in
        if len(args) == 1:
            # Send command
            for cmd in args[0]:
                joint = cmd[0]
                angle = cmd[1]
                error = angle - self.observations[joint]
                self.actions[joint] = error
                self.write()
            # Wait until it has reached
            waits = []
            for cmd in args[0]:
                waits.append(self.t_wait(cmd[0], cmd[1]))
            for wait in waits:
                wait.start()
            for wait in waits:
                wait.join()
        # One command was passed in
        elif len(args) == 2:
            self.activate([(args[0], args[1])])
        else:
            raise ValueError("Incorrect Number of Arguments")


    def t_wait(self, joint, angle):
        return threading.Thread(target=self.wait_for_position, args=(joint, angle))

    def close(self):
        self.server.close()






