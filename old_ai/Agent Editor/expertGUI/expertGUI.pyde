#line (x1,y1,x2,y2)
#

from Expert_File import Expert
from Button_File import Button
from Panel_File import Panel

expert_Num = 0
connect_mode = True
connect_one = None
connect_two = None
selected = None
guide_visable = False

sizeX = 1820
sizeY = 980

def setup():
    global sizeX
    global sizeY
    size(sizeX, sizeY)
    print ('start')
    expert_Num = 0
    buttons = 7
    panels = 1
    times = 0
    while times < buttons:
        button = Button('Button' + str(times))
        button.xpos = 75+(250*times)
        button.id = times
        print(button.name)
        times += 1
        
    panel = Panel('Panel' + str(times))
    panel.xpos = 0
    panel.ypos = 870
    panel.xwid = sizeX
    panel.ywid = sizeY
    
def mouseDragged ():
    global selected 
    moving_who = None
    if mouseButton == LEFT:
        for expert in Expert.experts:
            if expert.mouse_check():
                 moving_who = expert
                 selected = expert
        trash_control()            
        if moving_who != None:
            if pmouseY < 870:
                moving_who.xpos = pmouseX 
                moving_who.ypos = pmouseY
                print('Cords ' + str(pmouseX) + ', ' + str(pmouseY))
            else:
                moving_who.ypos = 870
                moving_who.xpos = pmouseX
                
            moving_who.draw_expert(0)

    elif mouseButton == RIGHT:
        connection_control()
    
def mouseClicked ():
    global connect_mode
    global selected
    global guide_visable
    global expert_Num
    
    #This is the connecting experts control system
    if mouseButton == RIGHT:
        connection_control()
                    
                
    #This is the user controls with left clicking   
    elif mouseButton == LEFT:
        for expert in Expert.experts:
            if expert.mouse_check():
                 moving_who = expert
                 selected = expert
                 
        trash_control()
        for button in Button.buttons:
            if button.mouse_check() == 0:
                button.draw_button(250)
                expert_god()
            elif button.mouse_check() == 1:
                button.draw_button(250)
                if guide_visable == True:
                    guide_visable = False
            
                elif guide_visable == False:
                    guide_visable = True
                
            elif button.mouse_check() == 3:
                button.draw_button(250)
                connect_mode = True
                print('Connect mode')
           
            elif button.mouse_check() == 4:
                button.draw_button(250)
                connect_mode = False
            
            elif button.mouse_check() == 6 and expert_Num > 0:
                button.draw_button(250)
                num_experts = len(Expert.experts)
                for expert in range(0, num_experts):
                    print(Expert.experts[0])
                    Expert.experts.remove(Expert.experts[0]) 
                    expert_Num = 0
        

def trash_control():
    for button in Button.buttons:
        if button.mouse_check() == 5:
            button.draw_button(250)
            for expert in Expert.experts:
                if expert.mouse_check():
                    for connections in Expert.experts:
                        if connections in expert.connect:
                            expert.connect.remove(connections)
                        if expert in connections.connect:
                            connections.connect.remove(expert)
                            
                    expert.experts.remove(expert)
                    print('Expert killed')
                
def connection_control():
    global connect_one
    global connect_two
    global connect_mode
    
    if connect_one == None:
        for expert in Expert.experts:
            if expert.mouse_check():
                connect_one = expert
                expert.draw_expert(250)
                print ('Connect One') 
                       
    else:
        for expert in Expert.experts:
            if expert.mouse_check():
                connect_two = expert
                expert.draw_expert(250)
                print ('Connect two')
                    
                      
    if connect_one != None and connect_two != None:
        if connect_mode == True:  
            connect_one.connect.append(connect_two)
            connect_two.connect.append(connect_one)
            print ('Connected')
                
        elif connect_mode == False:
            if connect_one != None and connect_two != None:
                if connect_two in connect_one.connect:
                    connect_one.connect.remove(connect_two)
                        
                if connect_one in connect_two.connect:
                    connect_two.connect.remove(connect_one)
                        
                print ('Disconnected')
                    
        connect_one = None
        connect_two = None

                                                                
def keyPressed():
    global connect_mode
    global connect_one
    global connect_two
    global guide_visable
    
    #Makes an expert
    if keyCode == 32:
       expert_god()
    elif keyCode == 67:
        connect_mode = True
    elif keyCode == 68:
        connect_mode = False
    elif keyCode == SHIFT:
        connect_one = None
        connect_two = None
    elif keyCode == 71:
        if guide_visable == True:
            guide_visable = False
            
        elif guide_visable == False:
            guide_visable = True
       
    #Changes Expert Type
    elif key == TAB:
        for expert in Expert.experts:    
            if expert.mouse_check():
                
                if expert.type_num == 1:
                    expert.colors = [113, 113, 113, 255]
                    expert.txt = str(expert.idnum) + ' is an OUTPUT'
                    expert.type_num += 1
                    
                elif expert.type_num == 2:
                    expert.colors = [250, 230, 80, 255]
                    expert.txt = str(expert.idnum) + ' is a DENSE'
                    expert.type_num += 1
                    
                elif expert.type_num == 3:
                    expert.colors = [100, 100, 255, 255]
                    expert.txt = str(expert.idnum) + ' is a NEAT'
                    expert.type_num += 1
                    
                elif expert.type_num == 4:
                    expert.colors = [100, 245, 245, 245]
                    expert.txt = str(expert.idnum) + ' is a CNN'
                    expert.type_num += 1
                    
                elif expert.type_num == 5:
                    expert.colors = [100, 255, 100, 255]
                    expert.txt = str(expert.idnum) + ' is a RNN'
                    expert.type_num += 1
                    
                elif expert.type_num == 6:
                    expert.colors = [245, 80, 80, 255]
                    expert.txt = str(expert.idnum) + ' is an INPUT'
                    expert.type_num = 1
                    
def expert_god():
    global expert_Num
    expert_Num = expert_Num + 1
    name = 'Expert'+ str(expert_Num)
    expert = Expert(name)
    expert.idnum = expert_Num
    expert.colors = [245, 80, 80, 255]
    expert.txt = str(expert.idnum) + ' is an INPUT'
    expert.draw_expert(0)
    print('Expert made')
    
def key_guide():
    global guide_visable 
    global sizeX
    global sizeY
    
    if guide_visable == True:
        fill(235, 100)
        #rect(sizeX - 150, 5, 145, 150)
        textSize(12)
        fill(0, 150)
        place = 20
        gap = 20
        text('Add Expert: SPACEBAR', sizeX - 145, place)
        place += gap
        text('Change Type: TAB ', sizeX - 145, place)
        place += gap
        text('Connect: C ', sizeX - 145, place)
        place += gap
        text('Disconnect: D ', sizeX - 145, place)
        place += gap
        text('Clear Connects: SHIFT', sizeX- 145, place)
        place += gap
        text('Toggle Guide: G ', sizeX- 145, place)
        
        

def draw ():
    num_active = 0
    background(255)
    for expert in Expert.experts:
        expert.draw_connect()
    
    for expert in Expert.experts:
        expert.draw_expert(0)
        
    for expert in Expert.experts:
        expert.draw_expert_list(num_active)
        num_active += 1
    
    for panel in Panel.panels:
        panel.draw_panel()
    
    for button in Button.buttons:
        button.draw_button(0)
    
    key_guide()
