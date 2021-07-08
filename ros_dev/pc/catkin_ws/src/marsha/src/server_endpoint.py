#!/usr/bin/env python

import rospy
#!/usr/bin/env python
from std_msgs.msg import Float64

from ros_tcp_endpoint import TcpServer, RosPublisher, RosSubscriber



def main():
    ros_node_name = rospy.get_param("/TCP_NODE_NAME", 'TCPServer')
    buffer_size = rospy.get_param("/TCP_BUFFER_SIZE", 1024)
    connections = rospy.get_param("/TCP_CONNECTIONS", 10)
    tcp_server = TcpServer(ros_node_name, buffer_size, connections)
    rospy.init_node(ros_node_name, anonymous=True)
    
    tcp_server.start({
        'state': RosPublisher('state', Float64),
        'control_effort': RosSubscriber('control_effort', Float64, tcp_server)
    })
    
    rospy.spin()


if __name__ == "__main__":
    main()
