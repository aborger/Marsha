#!/usr/bin/env python
import rospy
import tf

if __name__ == '__main__':
    rospy.init_node('broadcaset_fixed')
    ns = rospy.get_namespace()
    br = tf.TransformBroadcaster()
    rate = rospy.Rate(10.0)

    x_val = 0
    if ns is "right/":
        x_val = 0.5
    while not rospy.is_shutdown():
        br.sendTransform((0.5, 0.0, 0.0),
                         (0.0, 0.0, 0.0, 1.0),
                         rospy.Time.now(),
                         ns+"world",
                         "world")
        rate.sleep()