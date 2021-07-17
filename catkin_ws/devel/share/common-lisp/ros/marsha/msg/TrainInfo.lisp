; Auto-generated. Do not edit!


(cl:in-package marsha-msg)


;//! \htmlinclude TrainInfo.msg.html

(cl:defclass <TrainInfo> (roslisp-msg-protocol:ros-message)
  ((loss
    :reader loss
    :initarg :loss
    :type cl:float
    :initform 0.0))
)

(cl:defclass TrainInfo (<TrainInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrainInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrainInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marsha-msg:<TrainInfo> is deprecated: use marsha-msg:TrainInfo instead.")))

(cl:ensure-generic-function 'loss-val :lambda-list '(m))
(cl:defmethod loss-val ((m <TrainInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marsha-msg:loss-val is deprecated.  Use marsha-msg:loss instead.")
  (loss m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrainInfo>) ostream)
  "Serializes a message object of type '<TrainInfo>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'loss))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrainInfo>) istream)
  "Deserializes a message object of type '<TrainInfo>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'loss) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrainInfo>)))
  "Returns string type for a message object of type '<TrainInfo>"
  "marsha/TrainInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrainInfo)))
  "Returns string type for a message object of type 'TrainInfo"
  "marsha/TrainInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrainInfo>)))
  "Returns md5sum for a message object of type '<TrainInfo>"
  "0243a756440bd40111a2b7951b9a568e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrainInfo)))
  "Returns md5sum for a message object of type 'TrainInfo"
  "0243a756440bd40111a2b7951b9a568e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrainInfo>)))
  "Returns full string definition for message of type '<TrainInfo>"
  (cl:format cl:nil "float32 loss~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrainInfo)))
  "Returns full string definition for message of type 'TrainInfo"
  (cl:format cl:nil "float32 loss~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrainInfo>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrainInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'TrainInfo
    (cl:cons ':loss (loss msg))
))
