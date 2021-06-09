class Button:
    buttons = []
    
    def __init__(self, name):
        self.name = name
        self.id = None
        self.xpos = 150
        self.ypos = 900
        self.xwid = 150
        self.ywid = 50
        Button.buttons.append(self)
        if self.name == 'Button0':
            self.name = 'Add Expert'
        
        elif self.name == 'Button1':
            self.name = 'User Guide'
            
        elif self.name == 'Button3':
            self.name = 'Connect'
        
        elif self.name == 'Button4':
            self.name = 'Disconnect'
            
        elif self.name == 'Button5':
            self.name = 'Kill Expert'
            
        elif self.name == 'Button6':
            self.name = 'Reset GUI'

    def mouse_check (self):
        if pmouseX > self.xpos and pmouseX < self.xpos + self.xwid:
            if pmouseY > self.ypos - self.ywid and pmouseY < self.ypos + self.ywid:
                return self.id
    
    def draw_button (self, curves):
       
        if self.id == 6:
            fill (200, 25, 25, 200 + curves)
        elif self.id == 5:
            fill (100, 25, 200, 200 + curves)
        else:
            fill (180, 200 + curves)
        stroke (0)
        rect (self.xpos, self.ypos, self.xwid, self.ywid, 15 + curves/4)
        textSize (15)
        fill (0)
        text(self.name, self.xpos + self.xwid/4 , self.ypos + self.ywid * 3/5)
