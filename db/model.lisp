(defpackage :cl-warehouse-model
  (:use :cl :mito)
  (:import-from :cl-warehouse.db
   :connection-settings :with-connection)
  (:export :create-tables :insert-data))

(in-package :cl-warehouse-model)


(mito:deftable warehouses ()
  ((location :col-type (:varchar 50))
   (capacity :col-type (:integer))))

(mito:deftable boxes ()
  ((contents :col-type (:varchar 10))
   (value :col-type (:integer))
   (warehouse :col-type warehouses :references warehouses)))

(defun create-tables ()
  (mapcar #'mito:ensure-table-exists '(warehouses boxes)))

(defun insert-data ()
  (insert-data-for-warehouses)
  (insert-data-for-boxes))




(defun insert-data-for-warehouses ()  
  (mito:insert-dao (make-instance 'warehouses :location "Chicago" :capacity 3))
  (mito:insert-dao (make-instance 'warehouses :location "Chicago" :capacity 4))
  (mito:insert-dao (make-instance 'warehouses :location "New York" :capacity 7))
  (mito:insert-dao (make-instance 'warehouses :location "Los Angeles" :capacity 2))
  (mito:insert-dao (make-instance 'warehouses :location "San Francisco" :capacity 8)))

(defun insert-data-for-boxes ()  
  (mito:insert-dao (make-instance 'boxes :contents "Rocks" :value 180 :warehouse-id 1))
  (mito:insert-dao (make-instance 'boxes :contents "Paper" :value 250 :warehouse-id 1))
  (mito:insert-dao (make-instance 'boxes :contents "Scissors" :value 90 :warehouse-id 1))
  (mito:insert-dao (make-instance 'boxes :contents "Rocks" :value 180 :warehouse-id 2))
  (mito:insert-dao (make-instance 'boxes :contents "Paper" :value 250 :warehouse-id 2))
  (mito:insert-dao (make-instance 'boxes :contents "Scissors" :value 90 :warehouse-id 2))
  (mito:insert-dao (make-instance 'boxes :contents "Rocks" :value 180 :warehouse-id 3))
  (mito:insert-dao (make-instance 'boxes :contents "Paper" :value 250 :warehouse-id 3))
  (mito:insert-dao (make-instance 'boxes :contents "Scissors" :value 90 :warehouse-id 3))
  (mito:insert-dao (make-instance 'boxes :contents "Rocks" :value 180 :warehouse-id 4))
  (mito:insert-dao (make-instance 'boxes :contents "Paper" :value 250 :warehouse-id 5)))
