class Panel:
    
    panels = []
    
    def __init__ (self, name):
        self.name = name
        self.xpos = None
        self.ypos = None
        self.xwid = None
        self.ywid = None
        Panel.panels.append(self)
    
    def draw_panel(self):
        fill (225)
        stroke(0)
        rect(self.xpos, self.ypos, self.xwid, self.ywid)
        
        
