;; Auto-generated. Do not edit!


(when (boundp 'gazebo_msgs::PerformanceMetrics)
  (if (not (find-package "GAZEBO_MSGS"))
    (make-package "GAZEBO_MSGS"))
  (shadow 'PerformanceMetrics (find-package "GAZEBO_MSGS")))
(unless (find-package "GAZEBO_MSGS::PERFORMANCEMETRICS")
  (make-package "GAZEBO_MSGS::PERFORMANCEMETRICS"))

(in-package "ROS")
;;//! \htmlinclude PerformanceMetrics.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass gazebo_msgs::PerformanceMetrics
  :super ros::object
  :slots (_header _real_time_factor _sensors ))

(defmethod gazebo_msgs::PerformanceMetrics
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:real_time_factor __real_time_factor) 0.0)
    ((:sensors __sensors) (let (r) (dotimes (i 0) (push (instance gazebo_msgs::SensorPerformanceMetric :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _real_time_factor (float __real_time_factor))
   (setq _sensors __sensors)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:real_time_factor
   (&optional __real_time_factor)
   (if __real_time_factor (setq _real_time_factor __real_time_factor)) _real_time_factor)
  (:sensors
   (&rest __sensors)
   (if (keywordp (car __sensors))
       (send* _sensors __sensors)
     (progn
       (if __sensors (setq _sensors (car __sensors)))
       _sensors)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64 _real_time_factor
    8
    ;; gazebo_msgs/SensorPerformanceMetric[] _sensors
    (apply #'+ (send-all _sensors :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64 _real_time_factor
       (sys::poke _real_time_factor (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; gazebo_msgs/SensorPerformanceMetric[] _sensors
     (write-long (length _sensors) s)
     (dolist (elem _sensors)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64 _real_time_factor
     (setq _real_time_factor (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; gazebo_msgs/SensorPerformanceMetric[] _sensors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _sensors (let (r) (dotimes (i n) (push (instance gazebo_msgs::SensorPerformanceMetric :init) r)) r))
     (dolist (elem- _sensors)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get gazebo_msgs::PerformanceMetrics :md5sum-) "884f71fd5037b886ec5e126b83c4425a")
(setf (get gazebo_msgs::PerformanceMetrics :datatype-) "gazebo_msgs/PerformanceMetrics")
(setf (get gazebo_msgs::PerformanceMetrics :definition-)
      "Header header

float64 real_time_factor
gazebo_msgs/SensorPerformanceMetric[] sensors

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: gazebo_msgs/SensorPerformanceMetric
string name
float64 sim_update_rate
float64 real_update_rate
float64 fps

")



(provide :gazebo_msgs/PerformanceMetrics "884f71fd5037b886ec5e126b83c4425a")


