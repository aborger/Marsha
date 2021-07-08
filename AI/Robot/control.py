from AI.server import Server
import threading
import math
import time

NUM_JOINTS = 23

class Control:
    def __init__(self, is_reverse, id):
        self.server = Server(id)
        self.actions = [0] * NUM_JOINTS
        self.observations = []
        self.stop = False
        self.is_reverse = is_reverse

    def write(self):
        actions = []
        if self.is_reverse:
            for action in self.actions:
                actions.append(action * -1)
        else:
            for action in self.actions:
                actions.append(action)
        json = {"actions": actions}
        self.server.write(json)

    def get(self):
        try:
            obs = self.server.read()['positions']
            if self.is_reverse:
                true_obs = []
                for ob in obs:
                    true_obs.append(ob * -1)
                self.observations = true_obs
            else:
                self.observations = obs
            #print(self.observations)
            
        except:
            pass

    def stop_maneuver(self):
        print('===========stop===============')
        self.stop = True
        time.sleep(1)
        self.stop = False

        

    def deactivate(self, joint):
        self.actions[joint] = 0

    def wait_for_position(self, joint, angle):
        BUFFER = 1
        while True:
            self.get()
            # Control Theory
            error = angle - self.observations[joint]
            self.actions[joint] =  2/(1+math.exp(-0.2 *error)) -1
            # This part works
            #self.actions[joint] = error
            self.write()
            if self.observations[joint] < angle + BUFFER and self.observations[joint] > angle - BUFFER:
                self.actions[joint] = 0
                break
            elif self.stop:
                print(' I am stopping!!!!!!!1')
                self.actions[joint] = 0
                break

    def activate(self, *args):
        # A list of commands was passed in
        arg = args[0]
        if isinstance(arg, list):
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
        elif isinstance(arg, int):
            self.activate([(args[0], args[1])])
        elif len(arg) == 2:
            self.activate([(arg[0], arg[1])])
        else:
            raise ValueError("Incorrect Number of Arguments")


    def t_wait(self, joint, angle):
        return threading.Thread(target=self.wait_for_position, args=(joint, angle))

    def close(self):
        self.server.close()






