; Auto-generated. Do not edit!


(cl:in-package ros_tcp_endpoint-msg)


;//! \htmlinclude RosUnitySrvMessage.msg.html

(cl:defclass <RosUnitySrvMessage> (roslisp-msg-protocol:ros-message)
  ((srv_id
    :reader srv_id
    :initarg :srv_id
    :type cl:integer
    :initform 0)
   (is_request
    :reader is_request
    :initarg :is_request
    :type cl:boolean
    :initform cl:nil)
   (topic
    :reader topic
    :initarg :topic
    :type cl:string
    :initform "")
   (payload
    :reader payload
    :initarg :payload
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass RosUnitySrvMessage (<RosUnitySrvMessage>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RosUnitySrvMessage>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RosUnitySrvMessage)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_tcp_endpoint-msg:<RosUnitySrvMessage> is deprecated: use ros_tcp_endpoint-msg:RosUnitySrvMessage instead.")))

(cl:ensure-generic-function 'srv_id-val :lambda-list '(m))
(cl:defmethod srv_id-val ((m <RosUnitySrvMessage>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:srv_id-val is deprecated.  Use ros_tcp_endpoint-msg:srv_id instead.")
  (srv_id m))

(cl:ensure-generic-function 'is_request-val :lambda-list '(m))
(cl:defmethod is_request-val ((m <RosUnitySrvMessage>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:is_request-val is deprecated.  Use ros_tcp_endpoint-msg:is_request instead.")
  (is_request m))

(cl:ensure-generic-function 'topic-val :lambda-list '(m))
(cl:defmethod topic-val ((m <RosUnitySrvMessage>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:topic-val is deprecated.  Use ros_tcp_endpoint-msg:topic instead.")
  (topic m))

(cl:ensure-generic-function 'payload-val :lambda-list '(m))
(cl:defmethod payload-val ((m <RosUnitySrvMessage>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:payload-val is deprecated.  Use ros_tcp_endpoint-msg:payload instead.")
  (payload m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RosUnitySrvMessage>) ostream)
  "Serializes a message object of type '<RosUnitySrvMessage>"
  (cl:let* ((signed (cl:slot-value msg 'srv_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_request) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'topic))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'topic))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'payload))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'payload))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RosUnitySrvMessage>) istream)
  "Deserializes a message object of type '<RosUnitySrvMessage>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'srv_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'is_request) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'topic) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'topic) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'payload) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'payload)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RosUnitySrvMessage>)))
  "Returns string type for a message object of type '<RosUnitySrvMessage>"
  "ros_tcp_endpoint/RosUnitySrvMessage")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosUnitySrvMessage)))
  "Returns string type for a message object of type 'RosUnitySrvMessage"
  "ros_tcp_endpoint/RosUnitySrvMessage")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RosUnitySrvMessage>)))
  "Returns md5sum for a message object of type '<RosUnitySrvMessage>"
  "5e4da90c1cd45db0881a77473482b38e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RosUnitySrvMessage)))
  "Returns md5sum for a message object of type 'RosUnitySrvMessage"
  "5e4da90c1cd45db0881a77473482b38e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RosUnitySrvMessage>)))
  "Returns full string definition for message of type '<RosUnitySrvMessage>"
  (cl:format cl:nil "int32 srv_id~%bool is_request~%string topic~%uint8[] payload~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RosUnitySrvMessage)))
  "Returns full string definition for message of type 'RosUnitySrvMessage"
  (cl:format cl:nil "int32 srv_id~%bool is_request~%string topic~%uint8[] payload~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RosUnitySrvMessage>))
  (cl:+ 0
     4
     1
     4 (cl:length (cl:slot-value msg 'topic))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'payload) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RosUnitySrvMessage>))
  "Converts a ROS message object to a list"
  (cl:list 'RosUnitySrvMessage
    (cl:cons ':srv_id (srv_id msg))
    (cl:cons ':is_request (is_request msg))
    (cl:cons ':topic (topic msg))
    (cl:cons ':payload (payload msg))
))
