;; Auto-generated. Do not edit!


(when (boundp 'marsha::TrainInfo)
  (if (not (find-package "MARSHA"))
    (make-package "MARSHA"))
  (shadow 'TrainInfo (find-package "MARSHA")))
(unless (find-package "MARSHA::TRAININFO")
  (make-package "MARSHA::TRAININFO"))

(in-package "ROS")
;;//! \htmlinclude TrainInfo.msg.html


(defclass marsha::TrainInfo
  :super ros::object
  :slots (_loss ))

(defmethod marsha::TrainInfo
  (:init
   (&key
    ((:loss __loss) 0.0)
    )
   (send-super :init)
   (setq _loss (float __loss))
   self)
  (:loss
   (&optional __loss)
   (if __loss (setq _loss __loss)) _loss)
  (:serialization-length
   ()
   (+
    ;; float32 _loss
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _loss
       (sys::poke _loss (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _loss
     (setq _loss (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get marsha::TrainInfo :md5sum-) "0243a756440bd40111a2b7951b9a568e")
(setf (get marsha::TrainInfo :datatype-) "marsha/TrainInfo")
(setf (get marsha::TrainInfo :definition-)
      "float32 loss
")



(provide :marsha/TrainInfo "0243a756440bd40111a2b7951b9a568e")


