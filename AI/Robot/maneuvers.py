
def From_fold(c):
    c.activate(9, -90)

    c.activate([(11, -180), (12, -180), (14, -180)])

    c.activate(10, -90)

    c.activate(8, 110)

    print('Maneuver done')

def To_fold(c):

    c.activate(8, 0)

    c.activate(10, 0)

    c.activate([(11, 0), (12, 0), (14, 0)])

    c.activate(9, 0)

def To_object(c):
    pass

def From_object(c):
    pass

def To_pass(c):
    c.activate(11, -90)

def From_pass(c):
    c.activate(11, -180)

LIST = [From_fold, To_fold, To_object, From_object, To_pass, From_pass]