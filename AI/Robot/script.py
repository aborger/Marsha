

class Script:
    def __init__(self) -> None:
        self.control = None
        self.commands = None
        self.step = 0

    def run(self, control, commands):
        self.control = control
        self.commands = commands
        while True:
            self.control.write()
            self.control.get()
            self.control.activate(self._cmd_step()['speed'], self._cmd_step()['joint'])
            if self.control.wait_for_position(self._cmd_step()['joint'], self._cmd_step()['stop']):
                self.step += 1

    def cmd(self, joint, speed, stop):
        return {'joint': joint, 'speed':speed, 'stop':stop}
    
    def _cmd_step(self):
        return self.commands[self.step]