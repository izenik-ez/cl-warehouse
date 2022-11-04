(defsystem "cl-warehouse-test"
  :author "Xabier Gonzalez"
  :license ""
  :depends-on ("cl-warehouse"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:test-file "cl-warehouse"))))
  :description "Test system for cl-warehouse"
  :perform (test-op (op c)
                    (uiop:symbol-call
                     :fiveam '#:run!
                     (find-symbol* :all-test :cl-warehouse-test))))
