;; Auto-generated. Do not edit!


(when (boundp 'gazebo_msgs::SensorPerformanceMetric)
  (if (not (find-package "GAZEBO_MSGS"))
    (make-package "GAZEBO_MSGS"))
  (shadow 'SensorPerformanceMetric (find-package "GAZEBO_MSGS")))
(unless (find-package "GAZEBO_MSGS::SENSORPERFORMANCEMETRIC")
  (make-package "GAZEBO_MSGS::SENSORPERFORMANCEMETRIC"))

(in-package "ROS")
;;//! \htmlinclude SensorPerformanceMetric.msg.html


(defclass gazebo_msgs::SensorPerformanceMetric
  :super ros::object
  :slots (_name _sim_update_rate _real_update_rate _fps ))

(defmethod gazebo_msgs::SensorPerformanceMetric
  (:init
   (&key
    ((:name __name) "")
    ((:sim_update_rate __sim_update_rate) 0.0)
    ((:real_update_rate __real_update_rate) 0.0)
    ((:fps __fps) 0.0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _sim_update_rate (float __sim_update_rate))
   (setq _real_update_rate (float __real_update_rate))
   (setq _fps (float __fps))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:sim_update_rate
   (&optional __sim_update_rate)
   (if __sim_update_rate (setq _sim_update_rate __sim_update_rate)) _sim_update_rate)
  (:real_update_rate
   (&optional __real_update_rate)
   (if __real_update_rate (setq _real_update_rate __real_update_rate)) _real_update_rate)
  (:fps
   (&optional __fps)
   (if __fps (setq _fps __fps)) _fps)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; float64 _sim_update_rate
    8
    ;; float64 _real_update_rate
    8
    ;; float64 _fps
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; float64 _sim_update_rate
       (sys::poke _sim_update_rate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _real_update_rate
       (sys::poke _real_update_rate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _fps
       (sys::poke _fps (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _sim_update_rate
     (setq _sim_update_rate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _real_update_rate
     (setq _real_update_rate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _fps
     (setq _fps (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get gazebo_msgs::SensorPerformanceMetric :md5sum-) "01762ded18cfe9ebc7c8222667c99547")
(setf (get gazebo_msgs::SensorPerformanceMetric :datatype-) "gazebo_msgs/SensorPerformanceMetric")
(setf (get gazebo_msgs::SensorPerformanceMetric :definition-)
      "string name
float64 sim_update_rate
float64 real_update_rate
float64 fps

")



(provide :gazebo_msgs/SensorPerformanceMetric "01762ded18cfe9ebc7c8222667c99547")


