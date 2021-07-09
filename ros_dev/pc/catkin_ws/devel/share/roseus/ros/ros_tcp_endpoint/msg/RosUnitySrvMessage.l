;; Auto-generated. Do not edit!


(when (boundp 'ros_tcp_endpoint::RosUnitySrvMessage)
  (if (not (find-package "ROS_TCP_ENDPOINT"))
    (make-package "ROS_TCP_ENDPOINT"))
  (shadow 'RosUnitySrvMessage (find-package "ROS_TCP_ENDPOINT")))
(unless (find-package "ROS_TCP_ENDPOINT::ROSUNITYSRVMESSAGE")
  (make-package "ROS_TCP_ENDPOINT::ROSUNITYSRVMESSAGE"))

(in-package "ROS")
;;//! \htmlinclude RosUnitySrvMessage.msg.html


(defclass ros_tcp_endpoint::RosUnitySrvMessage
  :super ros::object
  :slots (_srv_id _is_request _topic _payload ))

(defmethod ros_tcp_endpoint::RosUnitySrvMessage
  (:init
   (&key
    ((:srv_id __srv_id) 0)
    ((:is_request __is_request) nil)
    ((:topic __topic) "")
    ((:payload __payload) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _srv_id (round __srv_id))
   (setq _is_request __is_request)
   (setq _topic (string __topic))
   (setq _payload __payload)
   self)
  (:srv_id
   (&optional __srv_id)
   (if __srv_id (setq _srv_id __srv_id)) _srv_id)
  (:is_request
   (&optional __is_request)
   (if __is_request (setq _is_request __is_request)) _is_request)
  (:topic
   (&optional __topic)
   (if __topic (setq _topic __topic)) _topic)
  (:payload
   (&optional __payload)
   (if __payload (setq _payload __payload)) _payload)
  (:serialization-length
   ()
   (+
    ;; int32 _srv_id
    4
    ;; bool _is_request
    1
    ;; string _topic
    4 (length _topic)
    ;; uint8[] _payload
    (* 1    (length _payload)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _srv_id
       (write-long _srv_id s)
     ;; bool _is_request
       (if _is_request (write-byte -1 s) (write-byte 0 s))
     ;; string _topic
       (write-long (length _topic) s) (princ _topic s)
     ;; uint8[] _payload
     (write-long (length _payload) s)
     (princ _payload s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _srv_id
     (setq _srv_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _is_request
     (setq _is_request (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _topic
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _topic (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8[] _payload
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _payload (make-array n :element-type :char))
     (replace _payload buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get ros_tcp_endpoint::RosUnitySrvMessage :md5sum-) "5e4da90c1cd45db0881a77473482b38e")
(setf (get ros_tcp_endpoint::RosUnitySrvMessage :datatype-) "ros_tcp_endpoint/RosUnitySrvMessage")
(setf (get ros_tcp_endpoint::RosUnitySrvMessage :definition-)
      "int32 srv_id
bool is_request
string topic
uint8[] payload
")



(provide :ros_tcp_endpoint/RosUnitySrvMessage "5e4da90c1cd45db0881a77473482b38e")


