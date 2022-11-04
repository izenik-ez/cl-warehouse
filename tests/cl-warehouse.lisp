(in-package :cl-user)
(defpackage :cl-warehouse-test
  (:use :cl
        :cl-warehouse
        :fiveam)
  (:export :all-tests :run-warehouse-tests))

(in-package :cl-warehouse-test)

;;(plan nil)


(def-suite all-tests
  :description "Root for warehouse tests")
(in-suite all-tests)

(test init (is-true (= 0 0)))

(defun run-warehouse-tests ()
  (fiveam:run! 'all-tests))
(
