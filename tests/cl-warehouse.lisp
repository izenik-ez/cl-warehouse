(in-package :cl-user)
(defpackage :cl-warehouse-test
  (:use :cl
        :cl-warehouse
        :fiveam
   :dexador)
  (:import-from :cl-warehouse :start :stop)
  (:shadowing-import-from :dexador :get :delete)
  (:export :all-tests :run-warehouse-tests))

(in-package :cl-warehouse-test)

;;(plan nil)


(def-suite all-tests
  :description "Root for warehouse tests")
(in-suite all-tests)


(defvar *handler* nil)

(test init (is (= 0 0) "OK" "Not ok"))



(defvar *host* "localhost")
(defvar *port* 5001)
(defvar *url* (concatenate 'string
                           "http://"
                           *host*
                           ":"
                           (write-to-string *port*)))

(defun add-page(page)
  (concatenate 'string *url* page))

(test index (multiple-value-bind (body status)
               (dex:get *url*)
             (declare (ignore body))
              (is (= status 200) "OK" "Wrong!")))

(test signal-an-error
  (signals http-request-not-found (dex:get (add-page "non-existing.html"))))
    

(defun run-warehouse-tests ()
  (let ((*handler* nil)
        (dex:*use-connection-pool* nil))
;;        (dexador.connection-cache::*threads-connection-pool*
;;          (make-hash-table :test 'equal :synchronized t)))
    (when *handler*
      (cl-warehouse:stop)
      (setf *handler* nil))
    (setf *handler* (cl-warehouse:start :port *port*))
    (unwind-protect
         (fiveam:run! 'all-tests)
      (cl-warehouse:stop)
      (setf *handler* nil))))

