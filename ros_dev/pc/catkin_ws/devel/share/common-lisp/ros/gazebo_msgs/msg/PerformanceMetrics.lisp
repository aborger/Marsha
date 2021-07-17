; Auto-generated. Do not edit!


(cl:in-package gazebo_msgs-msg)


;//! \htmlinclude PerformanceMetrics.msg.html

(cl:defclass <PerformanceMetrics> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (real_time_factor
    :reader real_time_factor
    :initarg :real_time_factor
    :type cl:float
    :initform 0.0)
   (sensors
    :reader sensors
    :initarg :sensors
    :type (cl:vector gazebo_msgs-msg:SensorPerformanceMetric)
   :initform (cl:make-array 0 :element-type 'gazebo_msgs-msg:SensorPerformanceMetric :initial-element (cl:make-instance 'gazebo_msgs-msg:SensorPerformanceMetric))))
)

(cl:defclass PerformanceMetrics (<PerformanceMetrics>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PerformanceMetrics>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PerformanceMetrics)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gazebo_msgs-msg:<PerformanceMetrics> is deprecated: use gazebo_msgs-msg:PerformanceMetrics instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PerformanceMetrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:header-val is deprecated.  Use gazebo_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'real_time_factor-val :lambda-list '(m))
(cl:defmethod real_time_factor-val ((m <PerformanceMetrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:real_time_factor-val is deprecated.  Use gazebo_msgs-msg:real_time_factor instead.")
  (real_time_factor m))

(cl:ensure-generic-function 'sensors-val :lambda-list '(m))
(cl:defmethod sensors-val ((m <PerformanceMetrics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:sensors-val is deprecated.  Use gazebo_msgs-msg:sensors instead.")
  (sensors m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PerformanceMetrics>) ostream)
  "Serializes a message object of type '<PerformanceMetrics>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'real_time_factor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sensors))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'sensors))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PerformanceMetrics>) istream)
  "Deserializes a message object of type '<PerformanceMetrics>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'real_time_factor) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sensors) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sensors)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'gazebo_msgs-msg:SensorPerformanceMetric))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PerformanceMetrics>)))
  "Returns string type for a message object of type '<PerformanceMetrics>"
  "gazebo_msgs/PerformanceMetrics")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PerformanceMetrics)))
  "Returns string type for a message object of type 'PerformanceMetrics"
  "gazebo_msgs/PerformanceMetrics")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PerformanceMetrics>)))
  "Returns md5sum for a message object of type '<PerformanceMetrics>"
  "884f71fd5037b886ec5e126b83c4425a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PerformanceMetrics)))
  "Returns md5sum for a message object of type 'PerformanceMetrics"
  "884f71fd5037b886ec5e126b83c4425a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PerformanceMetrics>)))
  "Returns full string definition for message of type '<PerformanceMetrics>"
  (cl:format cl:nil "Header header~%~%float64 real_time_factor~%gazebo_msgs/SensorPerformanceMetric[] sensors~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: gazebo_msgs/SensorPerformanceMetric~%string name~%float64 sim_update_rate~%float64 real_update_rate~%float64 fps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PerformanceMetrics)))
  "Returns full string definition for message of type 'PerformanceMetrics"
  (cl:format cl:nil "Header header~%~%float64 real_time_factor~%gazebo_msgs/SensorPerformanceMetric[] sensors~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: gazebo_msgs/SensorPerformanceMetric~%string name~%float64 sim_update_rate~%float64 real_update_rate~%float64 fps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PerformanceMetrics>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sensors) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PerformanceMetrics>))
  "Converts a ROS message object to a list"
  (cl:list 'PerformanceMetrics
    (cl:cons ':header (header msg))
    (cl:cons ':real_time_factor (real_time_factor msg))
    (cl:cons ':sensors (sensors msg))
))
