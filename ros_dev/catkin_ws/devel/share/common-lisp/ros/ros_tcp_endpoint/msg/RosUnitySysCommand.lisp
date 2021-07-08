; Auto-generated. Do not edit!


(cl:in-package ros_tcp_endpoint-msg)


;//! \htmlinclude RosUnitySysCommand.msg.html

(cl:defclass <RosUnitySysCommand> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type cl:string
    :initform "")
   (params_json
    :reader params_json
    :initarg :params_json
    :type cl:string
    :initform ""))
)

(cl:defclass RosUnitySysCommand (<RosUnitySysCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RosUnitySysCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RosUnitySysCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_tcp_endpoint-msg:<RosUnitySysCommand> is deprecated: use ros_tcp_endpoint-msg:RosUnitySysCommand instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <RosUnitySysCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:command-val is deprecated.  Use ros_tcp_endpoint-msg:command instead.")
  (command m))

(cl:ensure-generic-function 'params_json-val :lambda-list '(m))
(cl:defmethod params_json-val ((m <RosUnitySysCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-msg:params_json-val is deprecated.  Use ros_tcp_endpoint-msg:params_json instead.")
  (params_json m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RosUnitySysCommand>) ostream)
  "Serializes a message object of type '<RosUnitySysCommand>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'command))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'command))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'params_json))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'params_json))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RosUnitySysCommand>) istream)
  "Deserializes a message object of type '<RosUnitySysCommand>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'command) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'command) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'params_json) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'params_json) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RosUnitySysCommand>)))
  "Returns string type for a message object of type '<RosUnitySysCommand>"
  "ros_tcp_endpoint/RosUnitySysCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosUnitySysCommand)))
  "Returns string type for a message object of type 'RosUnitySysCommand"
  "ros_tcp_endpoint/RosUnitySysCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RosUnitySysCommand>)))
  "Returns md5sum for a message object of type '<RosUnitySysCommand>"
  "136891578342d9ff1f4f30a7e0d8ddac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RosUnitySysCommand)))
  "Returns md5sum for a message object of type 'RosUnitySysCommand"
  "136891578342d9ff1f4f30a7e0d8ddac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RosUnitySysCommand>)))
  "Returns full string definition for message of type '<RosUnitySysCommand>"
  (cl:format cl:nil "string command~%string params_json~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RosUnitySysCommand)))
  "Returns full string definition for message of type 'RosUnitySysCommand"
  (cl:format cl:nil "string command~%string params_json~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RosUnitySysCommand>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'command))
     4 (cl:length (cl:slot-value msg 'params_json))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RosUnitySysCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'RosUnitySysCommand
    (cl:cons ':command (command msg))
    (cl:cons ':params_json (params_json msg))
))
