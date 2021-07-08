;; Auto-generated. Do not edit!


(when (boundp 'ros_tcp_endpoint::RosUnityError)
  (if (not (find-package "ROS_TCP_ENDPOINT"))
    (make-package "ROS_TCP_ENDPOINT"))
  (shadow 'RosUnityError (find-package "ROS_TCP_ENDPOINT")))
(unless (find-package "ROS_TCP_ENDPOINT::ROSUNITYERROR")
  (make-package "ROS_TCP_ENDPOINT::ROSUNITYERROR"))

(in-package "ROS")
;;//! \htmlinclude RosUnityError.msg.html


(defclass ros_tcp_endpoint::RosUnityError
  :super ros::object
  :slots (_message ))

(defmethod ros_tcp_endpoint::RosUnityError
  (:init
   (&key
    ((:message __message) "")
    )
   (send-super :init)
   (setq _message (string __message))
   self)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get ros_tcp_endpoint::RosUnityError :md5sum-) "5f003d6bcc824cbd51361d66d8e4f76c")
(setf (get ros_tcp_endpoint::RosUnityError :datatype-) "ros_tcp_endpoint/RosUnityError")
(setf (get ros_tcp_endpoint::RosUnityError :definition-)
      "string message
")



(provide :ros_tcp_endpoint/RosUnityError "5f003d6bcc824cbd51361d66d8e4f76c")


