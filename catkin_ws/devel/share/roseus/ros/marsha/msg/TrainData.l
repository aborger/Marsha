;; Auto-generated. Do not edit!


(when (boundp 'marsha::TrainData)
  (if (not (find-package "MARSHA"))
    (make-package "MARSHA"))
  (shadow 'TrainData (find-package "MARSHA")))
(unless (find-package "MARSHA::TRAINDATA")
  (make-package "MARSHA::TRAINDATA"))

(in-package "ROS")
;;//! \htmlinclude TrainData.msg.html


(defclass marsha::TrainData
  :super ros::object
  :slots (_targets ))

(defmethod marsha::TrainData
  (:init
   (&key
    ((:targets __targets) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _targets __targets)
   self)
  (:targets
   (&optional __targets)
   (if __targets (setq _targets __targets)) _targets)
  (:serialization-length
   ()
   (+
    ;; float32[] _targets
    (* 4    (length _targets)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _targets
     (write-long (length _targets) s)
     (dotimes (i (length _targets))
       (sys::poke (elt _targets i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _targets
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _targets (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _targets i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get marsha::TrainData :md5sum-) "aa3cd371077e3b3151f9319b3ebdff23")
(setf (get marsha::TrainData :datatype-) "marsha/TrainData")
(setf (get marsha::TrainData :definition-)
      "float32[] targets

")



(provide :marsha/TrainData "aa3cd371077e3b3151f9319b3ebdff23")


