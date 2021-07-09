;; Auto-generated. Do not edit!


(when (boundp 'ros_tcp_endpoint::RosUnitySysCommand)
  (if (not (find-package "ROS_TCP_ENDPOINT"))
    (make-package "ROS_TCP_ENDPOINT"))
  (shadow 'RosUnitySysCommand (find-package "ROS_TCP_ENDPOINT")))
(unless (find-package "ROS_TCP_ENDPOINT::ROSUNITYSYSCOMMAND")
  (make-package "ROS_TCP_ENDPOINT::ROSUNITYSYSCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude RosUnitySysCommand.msg.html


(defclass ros_tcp_endpoint::RosUnitySysCommand
  :super ros::object
  :slots (_command _params_json ))

(defmethod ros_tcp_endpoint::RosUnitySysCommand
  (:init
   (&key
    ((:command __command) "")
    ((:params_json __params_json) "")
    )
   (send-super :init)
   (setq _command (string __command))
   (setq _params_json (string __params_json))
   self)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:params_json
   (&optional __params_json)
   (if __params_json (setq _params_json __params_json)) _params_json)
  (:serialization-length
   ()
   (+
    ;; string _command
    4 (length _command)
    ;; string _params_json
    4 (length _params_json)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _command
       (write-long (length _command) s) (princ _command s)
     ;; string _params_json
       (write-long (length _params_json) s) (princ _params_json s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _params_json
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _params_json (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get ros_tcp_endpoint::RosUnitySysCommand :md5sum-) "136891578342d9ff1f4f30a7e0d8ddac")
(setf (get ros_tcp_endpoint::RosUnitySysCommand :datatype-) "ros_tcp_endpoint/RosUnitySysCommand")
(setf (get ros_tcp_endpoint::RosUnitySysCommand :definition-)
      "string command
string params_json
")



(provide :ros_tcp_endpoint/RosUnitySysCommand "136891578342d9ff1f4f30a7e0d8ddac")


