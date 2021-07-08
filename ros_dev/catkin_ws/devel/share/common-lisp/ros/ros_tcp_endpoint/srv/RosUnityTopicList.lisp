; Auto-generated. Do not edit!


(cl:in-package ros_tcp_endpoint-srv)


;//! \htmlinclude RosUnityTopicList-request.msg.html

(cl:defclass <RosUnityTopicList-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass RosUnityTopicList-request (<RosUnityTopicList-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RosUnityTopicList-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RosUnityTopicList-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_tcp_endpoint-srv:<RosUnityTopicList-request> is deprecated: use ros_tcp_endpoint-srv:RosUnityTopicList-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RosUnityTopicList-request>) ostream)
  "Serializes a message object of type '<RosUnityTopicList-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RosUnityTopicList-request>) istream)
  "Deserializes a message object of type '<RosUnityTopicList-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RosUnityTopicList-request>)))
  "Returns string type for a service object of type '<RosUnityTopicList-request>"
  "ros_tcp_endpoint/RosUnityTopicListRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosUnityTopicList-request)))
  "Returns string type for a service object of type 'RosUnityTopicList-request"
  "ros_tcp_endpoint/RosUnityTopicListRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RosUnityTopicList-request>)))
  "Returns md5sum for a message object of type '<RosUnityTopicList-request>"
  "b0eef9a05d4e829092fc2f2c3c2aad3d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RosUnityTopicList-request)))
  "Returns md5sum for a message object of type 'RosUnityTopicList-request"
  "b0eef9a05d4e829092fc2f2c3c2aad3d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RosUnityTopicList-request>)))
  "Returns full string definition for message of type '<RosUnityTopicList-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RosUnityTopicList-request)))
  "Returns full string definition for message of type 'RosUnityTopicList-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RosUnityTopicList-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RosUnityTopicList-request>))
  "Converts a ROS message object to a list"
  (cl:list 'RosUnityTopicList-request
))
;//! \htmlinclude RosUnityTopicList-response.msg.html

(cl:defclass <RosUnityTopicList-response> (roslisp-msg-protocol:ros-message)
  ((topics
    :reader topics
    :initarg :topics
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass RosUnityTopicList-response (<RosUnityTopicList-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RosUnityTopicList-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RosUnityTopicList-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_tcp_endpoint-srv:<RosUnityTopicList-response> is deprecated: use ros_tcp_endpoint-srv:RosUnityTopicList-response instead.")))

(cl:ensure-generic-function 'topics-val :lambda-list '(m))
(cl:defmethod topics-val ((m <RosUnityTopicList-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tcp_endpoint-srv:topics-val is deprecated.  Use ros_tcp_endpoint-srv:topics instead.")
  (topics m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RosUnityTopicList-response>) ostream)
  "Serializes a message object of type '<RosUnityTopicList-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'topics))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'topics))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RosUnityTopicList-response>) istream)
  "Deserializes a message object of type '<RosUnityTopicList-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'topics) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'topics)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RosUnityTopicList-response>)))
  "Returns string type for a service object of type '<RosUnityTopicList-response>"
  "ros_tcp_endpoint/RosUnityTopicListResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosUnityTopicList-response)))
  "Returns string type for a service object of type 'RosUnityTopicList-response"
  "ros_tcp_endpoint/RosUnityTopicListResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RosUnityTopicList-response>)))
  "Returns md5sum for a message object of type '<RosUnityTopicList-response>"
  "b0eef9a05d4e829092fc2f2c3c2aad3d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RosUnityTopicList-response)))
  "Returns md5sum for a message object of type 'RosUnityTopicList-response"
  "b0eef9a05d4e829092fc2f2c3c2aad3d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RosUnityTopicList-response>)))
  "Returns full string definition for message of type '<RosUnityTopicList-response>"
  (cl:format cl:nil "string[] topics~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RosUnityTopicList-response)))
  "Returns full string definition for message of type 'RosUnityTopicList-response"
  (cl:format cl:nil "string[] topics~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RosUnityTopicList-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'topics) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RosUnityTopicList-response>))
  "Converts a ROS message object to a list"
  (cl:list 'RosUnityTopicList-response
    (cl:cons ':topics (topics msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'RosUnityTopicList)))
  'RosUnityTopicList-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'RosUnityTopicList)))
  'RosUnityTopicList-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosUnityTopicList)))
  "Returns string type for a service object of type '<RosUnityTopicList>"
  "ros_tcp_endpoint/RosUnityTopicList")