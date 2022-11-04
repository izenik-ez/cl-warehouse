(in-package :cl-user)
(defpackage cl-warehouse.web
  (:use :cl
        :caveman2
        :cl-warehouse.config
        :cl-warehouse.view
        :cl-warehouse.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :cl-warehouse.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

(defvar *alerts* '())

(mito:connect-toplevel :sqlite3 :database-name
                       (merge-pathnames #P"warehouse.db" *application-root*))
(mito:deftable boxes ()
  ((contents :col-type (:varchar 10))
   (value :col-type (:integer))
   (warehouse :col-type warehouses :references warehouses)))

(mito:deftable boxes ()
  ((contents :col-type (:varchar 50))
   (value :col-type (:integer))
   (warehouse :col-type warehouses :references warehouses)))

;; utils
(defun get-param (name parsed)
  "Get param values from _parsed"
  (cdr (assoc name parsed :test #'string=)))

(defun get-order-by (direction sort-by)
  "Construct sxql:order-by list values"
  (let ((dir (if (string= direction "asc")
                 :asc
                 :desc))
        (sortby (cond
                  ((string= sort-by "location") :location)
                  ((string= sort-by "capacity") :capacity)
                  ((string= sort-by "contents") :contents)
                  ((string= sort-by "value") :value)
                  (t :id))))
    (list dir sortby)))

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
