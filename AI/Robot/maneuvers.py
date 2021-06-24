
def Unfold(c):
    c.activate(9, -90)

    c.activate([(11, -180), (12, -180), (14, -180)])

    c.activate(10, -90)

    c.activate([(8, 110), (11, -90)])

    print('Maneuver done')

def Fold_up(c):
    c.activate([(8, 110), (11, -90)])

    c.activate([(8, 0), (11, -180)])

    c.activate(10, 0)

    c.activate([(11, 0), (12, 0), (14, 0)])

    c.activate(9, 0)

LIST = [Unfold, Fold_up]