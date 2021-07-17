; Auto-generated. Do not edit!


(cl:in-package marsha-msg)


;//! \htmlinclude TrainData.msg.html

(cl:defclass <TrainData> (roslisp-msg-protocol:ros-message)
  ((targets
    :reader targets
    :initarg :targets
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass TrainData (<TrainData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrainData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrainData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marsha-msg:<TrainData> is deprecated: use marsha-msg:TrainData instead.")))

(cl:ensure-generic-function 'targets-val :lambda-list '(m))
(cl:defmethod targets-val ((m <TrainData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marsha-msg:targets-val is deprecated.  Use marsha-msg:targets instead.")
  (targets m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrainData>) ostream)
  "Serializes a message object of type '<TrainData>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'targets))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'targets))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrainData>) istream)
  "Deserializes a message object of type '<TrainData>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'targets) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'targets)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrainData>)))
  "Returns string type for a message object of type '<TrainData>"
  "marsha/TrainData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrainData)))
  "Returns string type for a message object of type 'TrainData"
  "marsha/TrainData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrainData>)))
  "Returns md5sum for a message object of type '<TrainData>"
  "aa3cd371077e3b3151f9319b3ebdff23")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrainData)))
  "Returns md5sum for a message object of type 'TrainData"
  "aa3cd371077e3b3151f9319b3ebdff23")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrainData>)))
  "Returns full string definition for message of type '<TrainData>"
  (cl:format cl:nil "float32[] targets~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrainData)))
  "Returns full string definition for message of type 'TrainData"
  (cl:format cl:nil "float32[] targets~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrainData>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'targets) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrainData>))
  "Converts a ROS message object to a list"
  (cl:list 'TrainData
    (cl:cons ':targets (targets msg))
))
