; Auto-generated. Do not edit!


(cl:in-package ros_tcp_endpoint-msg)


;//! \htmlinclude RosUnityError.msg.html

(cl:defclass <RosUnityError> (roslisp-msg-protocol:ros-message)
  ((message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass RosUnityError (<RosUnityError>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RosUnityError>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RosUnityError)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_tcp_endpoint-msg:<RosUnityError> is deprecated: use ros_tcp_endpoint-msg:RosUnityError instead.")))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <RosUnityError>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:message-val is deprecated.  Use ros_tcp_endpoint-msg:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RosUnityError>) ostream)
  "Serializes a message object of type '<RosUnityError>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RosUnityError>) istream)
  "Deserializes a message object of type '<RosUnityError>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RosUnityError>)))
  "Returns string type for a message object of type '<RosUnityError>"
  "ros_tcp_endpoint/RosUnityError")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosUnityError)))
  "Returns string type for a message object of type 'RosUnityError"
  "ros_tcp_endpoint/RosUnityError")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RosUnityError>)))
  "Returns md5sum for a message object of type '<RosUnityError>"
  "5f003d6bcc824cbd51361d66d8e4f76c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RosUnityError)))
  "Returns md5sum for a message object of type 'RosUnityError"
  "5f003d6bcc824cbd51361d66d8e4f76c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RosUnityError>)))
  "Returns full string definition for message of type '<RosUnityError>"
  (cl:format cl:nil "string message~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RosUnityError)))
  "Returns full string definition for message of type 'RosUnityError"
  (cl:format cl:nil "string message~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RosUnityError>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RosUnityError>))
  "Converts a ROS message object to a list"
  (cl:list 'RosUnityError
    (cl:cons ':message (message msg))
))
