
(cl:in-package :asdf)

(defsystem "marsha-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Floats" :depends-on ("_package_Floats"))
    (:file "_package_Floats" :depends-on ("_package"))
    (:file "Floats" :depends-on ("_package_Floats"))
    (:file "_package_Floats" :depends-on ("_package"))
    (:file "Log" :depends-on ("_package_Log"))
    (:file "_package_Log" :depends-on ("_package"))
    (:file "Log" :depends-on ("_package_Log"))
    (:file "_package_Log" :depends-on ("_package"))
    (:file "TrainData" :depends-on ("_package_TrainData"))
    (:file "_package_TrainData" :depends-on ("_package"))
    (:file "TrainData" :depends-on ("_package_TrainData"))
    (:file "_package_TrainData" :depends-on ("_package"))
  ))