import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
import sys


class Planner(object):

    def __init__(self):
        super(Planner, self).__init__()

        moveit_commander.roscpp_initialize(sys.argv)
        rospy.init_node('Planner')

        self.robot = moveit_commander.RobotCommander()

        self.scene = moveit_commander.PlanningSceneInterface()

        self.move_group = moveit_commander.MoveGroupCommander("panda_arm")


    def go_to_position(self, position):
        pos_goal = geometry_msgs.msg.Pose()
        pos_goal.position.x = position[0]
        pos_goal.position.y = position[1]
        pos_goal.position.z = position[2]

        self.move_group.set_pose_target(pos_goal)

        plan = move_group.go(wait=True)

        move_group.stop()

        move_group.clear_pose_targets()

def main():
    print('starting...')
    try:
        print("Press enter to start")
        raw_input()
        print("Actually starting...")
        planner = Planner()
        planner.go_to_position()
    except rospy.ROSInterruptException:
        return
    except KeyboardInterrupt:
        return
    except Exception as e:
        raise e

