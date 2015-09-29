#lang planet neil/sicp

;;
;; Exercise3.25
;; Created by Soyn.29/9/15
;; @Brief:Generalizing one- and two-dimensional tables, show how to implement a table in which
;; values are stored under an arbitrary number of keys and different values may be stored under different
;; numbers of keys. The lookup and insert! procedures should take as input a list of keys used to access
;; the table.

( define (insert! key-list value table)
   ( if (list? key-list)
        ( let ( ( current-key ( car key-list))
                ( remain-key (cdr key-list)))
           ( let ( ( record ( assoc current-key ( cdr table))))
              ( cond
                 ;1.the slot is blank
                 ;update the value
                 ( ( and record ( null? remain-key))
                   ( set-cdr! record value)
                   table)
                 ;2.the slot is's blank
                 ;inset! the value recursionly
                 ( ( and record remain-key)
                   ( insert! remain-key value record)
                   table)
                 ;3.no record, but has keys
                 ;1).create the subtable.2).insert into the subtable.3).add the subtable into the table
                 (( and ( not record) ( not ( null? remain-key)))
                  ( join-in-table ( insert! remain-key value ( make-table current-key))table)
                  table)
                 ;4.no record, and has no keys
                 ;create the record and add into the table
                 (( and ( not record) ( null? remain-key))
                  ( let ( ( new-record ( cons current-key value)))
                     ( join-in-table new-record table)
                     table)))))
        ( insert! (list key-list) value table)))   ;convert the single key into the list

( define (join-in-table new-record table)
   ( set-cdr! table
              ( cons new-record ( cdr table))))

( define (lookup key-list table)
   ( if (list? key-list)
        ( let (( current-key ( car key-list))
               (remain-key ( cdr key-list)))
           (let (( record (assoc current-key ( cdr table))))
             (if record
                 (if (null? remain-key)
                     (cdr record)
                     (lookup remain-key record))
                 false)))
        (lookup (list key-list) table)))

(define ( make-table table-name)
  ( if (null? table-name)
       (list '*table*')
       table-name))

( define (assoc key records)
   ( cond ((null? records)
           false)
          (( equal? key ( caar records))
           ( car records))
          ( else
            ( assoc key (cdr records)))))