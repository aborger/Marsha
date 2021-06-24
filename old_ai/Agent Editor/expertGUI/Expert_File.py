class Expert:

    experts = []

    def __init__(self, name):
        self.name = name
        self.type_num = 1
        self.idnum = 0
        self.colors = None
        self.txt = None
        self.xpos = 125
        self.ypos = 30
        self.connect = []
        self.iconsize =  50
        Expert.experts.append(self)
   
    def mouse_check (self):
        if pmouseX > self.xpos - self.iconsize and pmouseX < self.xpos + self.iconsize:
            if pmouseY > self.ypos - self.iconsize and pmouseY < self.ypos + self.iconsize:
                return True
            
    def draw_expert (self, opacity):
        fill(self.colors[0], self.colors[1], self.colors[2], self.colors[3])
        stroke (0)
        textSize(10)    
        circle (self.xpos, self.ypos, self.iconsize)
        fill (0)
        text(self.idnum, self.xpos - self.iconsize/10, self.ypos + self.iconsize* 1/10)
    
    def draw_expert_list(self, num_active):
        yval = 5 + 25*(num_active)
        txt = None
        fill(self.colors[0], self.colors[1], self.colors[2], 100)
        stroke(0)
        rect(5, yval, 90, 20)
        fill (0)
        textSize(10)
        if self.type_num == 1:
            txt = str(self.idnum) + ' is a CNN'
        elif self.type_num == 2:
            txt = str(self.idnum) + ' is a RNN'
        elif self.type_num == 3:
            txt = str(self.idnum) + ' is a DENSE'
        elif self.type_num == 4:
            txt = str(self.idnum) + ' is a NEAT'
        elif self.type_num == 5:
            txt = str(self.idnum) + ' is an INPUT'
        elif self.type_num == 6:
            txt = str(self.idnum) + ' is an OUTPUT'
            
        text(self.txt, 10, yval + 15)
        
    def draw_connect (self):
        stroke(0)
        for lines in self.connect:
                line(self.xpos, self.ypos, lines.xpos, lines.ypos)
