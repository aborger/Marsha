import roslibpy



class log_node(object):
     def __init__(self, host, port):
          self.ros = roslibpy.Ros(host=host, port=9090)

          self.log_publisher = roslibpy.Topic(self.ros, 'bridgeLog', 'marsha/Log')

     def debug(self, msg):
        self.log(msg, 0)

     def info(self, msg):
         self.log(msg, 1)

     def warn(self, msg):
         self.log(msg, 2)

     def err(self, msg):
         self.log(msg, 3)

     def fatal(self, msg):
         self.log(msg, 4)

     def log(self, msg, lvl):
          if lvl > 0:
               print('[' + str(lvl) + '] ' + msg)
          self.log_publisher.publish({"logLevel":lvl, "msg":msg})



