;; Auto-generated. Do not edit!


(when (boundp 'ros_tcp_endpoint::RosUnityTopicList)
  (if (not (find-package "ROS_TCP_ENDPOINT"))
    (make-package "ROS_TCP_ENDPOINT"))
  (shadow 'RosUnityTopicList (find-package "ROS_TCP_ENDPOINT")))
(unless (find-package "ROS_TCP_ENDPOINT::ROSUNITYTOPICLIST")
  (make-package "ROS_TCP_ENDPOINT::ROSUNITYTOPICLIST"))
(unless (find-package "ROS_TCP_ENDPOINT::ROSUNITYTOPICLISTREQUEST")
  (make-package "ROS_TCP_ENDPOINT::ROSUNITYTOPICLISTREQUEST"))
(unless (find-package "ROS_TCP_ENDPOINT::ROSUNITYTOPICLISTRESPONSE")
  (make-package "ROS_TCP_ENDPOINT::ROSUNITYTOPICLISTRESPONSE"))

(in-package "ROS")





(defclass ros_tcp_endpoint::RosUnityTopicListRequest
  :super ros::object
  :slots ())

(defmethod ros_tcp_endpoint::RosUnityTopicListRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass ros_tcp_endpoint::RosUnityTopicListResponse
  :super ros::object
  :slots (_topics ))

(defmethod ros_tcp_endpoint::RosUnityTopicListResponse
  (:init
   (&key
    ((:topics __topics) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _topics __topics)
   self)
  (:topics
   (&optional __topics)
   (if __topics (setq _topics __topics)) _topics)
  (:serialization-length
   ()
   (+
    ;; string[] _topics
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _topics)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _topics
     (write-long (length _topics) s)
     (dolist (elem _topics)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _topics
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _topics (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _topics i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass ros_tcp_endpoint::RosUnityTopicList
  :super ros::object
  :slots ())

(setf (get ros_tcp_endpoint::RosUnityTopicList :md5sum-) "b0eef9a05d4e829092fc2f2c3c2aad3d")
(setf (get ros_tcp_endpoint::RosUnityTopicList :datatype-) "ros_tcp_endpoint/RosUnityTopicList")
(setf (get ros_tcp_endpoint::RosUnityTopicList :request) ros_tcp_endpoint::RosUnityTopicListRequest)
(setf (get ros_tcp_endpoint::RosUnityTopicList :response) ros_tcp_endpoint::RosUnityTopicListResponse)

(defmethod ros_tcp_endpoint::RosUnityTopicListRequest
  (:response () (instance ros_tcp_endpoint::RosUnityTopicListResponse :init)))

(setf (get ros_tcp_endpoint::RosUnityTopicListRequest :md5sum-) "b0eef9a05d4e829092fc2f2c3c2aad3d")
(setf (get ros_tcp_endpoint::RosUnityTopicListRequest :datatype-) "ros_tcp_endpoint/RosUnityTopicListRequest")
(setf (get ros_tcp_endpoint::RosUnityTopicListRequest :definition-)
      "---
string[] topics
")

(setf (get ros_tcp_endpoint::RosUnityTopicListResponse :md5sum-) "b0eef9a05d4e829092fc2f2c3c2aad3d")
(setf (get ros_tcp_endpoint::RosUnityTopicListResponse :datatype-) "ros_tcp_endpoint/RosUnityTopicListResponse")
(setf (get ros_tcp_endpoint::RosUnityTopicListResponse :definition-)
      "---
string[] topics
")



(provide :ros_tcp_endpoint/RosUnityTopicList "b0eef9a05d4e829092fc2f2c3c2aad3d")


