;; Auto-generated. Do not edit!


(when (boundp 'marsha::Log)
  (if (not (find-package "MARSHA"))
    (make-package "MARSHA"))
  (shadow 'Log (find-package "MARSHA")))
(unless (find-package "MARSHA::LOG")
  (make-package "MARSHA::LOG"))

(in-package "ROS")
;;//! \htmlinclude Log.msg.html


(defclass marsha::Log
  :super ros::object
  :slots (_logLevel _msg ))

(defmethod marsha::Log
  (:init
   (&key
    ((:logLevel __logLevel) 0)
    ((:msg __msg) "")
    )
   (send-super :init)
   (setq _logLevel (round __logLevel))
   (setq _msg (string __msg))
   self)
  (:logLevel
   (&optional __logLevel)
   (if __logLevel (setq _logLevel __logLevel)) _logLevel)
  (:msg
   (&optional __msg)
   (if __msg (setq _msg __msg)) _msg)
  (:serialization-length
   ()
   (+
    ;; int32 _logLevel
    4
    ;; string _msg
    4 (length _msg)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _logLevel
       (write-long _logLevel s)
     ;; string _msg
       (write-long (length _msg) s) (princ _msg s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _logLevel
     (setq _logLevel (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _msg
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _msg (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get marsha::Log :md5sum-) "342fa202d332a78f4d751b1a33e13a8f")
(setf (get marsha::Log :datatype-) "marsha/Log")
(setf (get marsha::Log :definition-)
      "int32 logLevel
string msg
")



(provide :marsha/Log "342fa202d332a78f4d751b1a33e13a8f")


