; Auto-generated. Do not edit!


(cl:in-package gazebo_msgs-msg)


;//! \htmlinclude SensorPerformanceMetric.msg.html

(cl:defclass <SensorPerformanceMetric> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (sim_update_rate
    :reader sim_update_rate
    :initarg :sim_update_rate
    :type cl:float
    :initform 0.0)
   (real_update_rate
    :reader real_update_rate
    :initarg :real_update_rate
    :type cl:float
    :initform 0.0)
   (fps
    :reader fps
    :initarg :fps
    :type cl:float
    :initform 0.0))
)

(cl:defclass SensorPerformanceMetric (<SensorPerformanceMetric>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SensorPerformanceMetric>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SensorPerformanceMetric)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gazebo_msgs-msg:<SensorPerformanceMetric> is deprecated: use gazebo_msgs-msg:SensorPerformanceMetric instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <SensorPerformanceMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:name-val is deprecated.  Use gazebo_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'sim_update_rate-val :lambda-list '(m))
(cl:defmethod sim_update_rate-val ((m <SensorPerformanceMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:sim_update_rate-val is deprecated.  Use gazebo_msgs-msg:sim_update_rate instead.")
  (sim_update_rate m))

(cl:ensure-generic-function 'real_update_rate-val :lambda-list '(m))
(cl:defmethod real_update_rate-val ((m <SensorPerformanceMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:real_update_rate-val is deprecated.  Use gazebo_msgs-msg:real_update_rate instead.")
  (real_update_rate m))

(cl:ensure-generic-function 'fps-val :lambda-list '(m))
(cl:defmethod fps-val ((m <SensorPerformanceMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gazebo_msgs-msg:fps-val is deprecated.  Use gazebo_msgs-msg:fps instead.")
  (fps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SensorPerformanceMetric>) ostream)
  "Serializes a message object of type '<SensorPerformanceMetric>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'sim_update_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'real_update_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'fps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SensorPerformanceMetric>) istream)
  "Deserializes a message object of type '<SensorPerformanceMetric>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sim_update_rate) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'real_update_rate) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fps) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SensorPerformanceMetric>)))
  "Returns string type for a message object of type '<SensorPerformanceMetric>"
  "gazebo_msgs/SensorPerformanceMetric")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SensorPerformanceMetric)))
  "Returns string type for a message object of type 'SensorPerformanceMetric"
  "gazebo_msgs/SensorPerformanceMetric")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SensorPerformanceMetric>)))
  "Returns md5sum for a message object of type '<SensorPerformanceMetric>"
  "01762ded18cfe9ebc7c8222667c99547")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SensorPerformanceMetric)))
  "Returns md5sum for a message object of type 'SensorPerformanceMetric"
  "01762ded18cfe9ebc7c8222667c99547")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SensorPerformanceMetric>)))
  "Returns full string definition for message of type '<SensorPerformanceMetric>"
  (cl:format cl:nil "string name~%float64 sim_update_rate~%float64 real_update_rate~%float64 fps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SensorPerformanceMetric)))
  "Returns full string definition for message of type 'SensorPerformanceMetric"
  (cl:format cl:nil "string name~%float64 sim_update_rate~%float64 real_update_rate~%float64 fps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SensorPerformanceMetric>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SensorPerformanceMetric>))
  "Converts a ROS message object to a list"
  (cl:list 'SensorPerformanceMetric
    (cl:cons ':name (name msg))
    (cl:cons ':sim_update_rate (sim_update_rate msg))
    (cl:cons ':real_update_rate (real_update_rate msg))
    (cl:cons ':fps (fps msg))
))
