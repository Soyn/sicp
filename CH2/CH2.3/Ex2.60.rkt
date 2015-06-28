#lang racket
;Ex2.60
( define (element-of-set? x set)
   (cond ( ( null? set) #f)
        ( ( equal? x ( car set)) #t)
        ( else (element-of-set? x ( cdr set)))))

( define ( adjoin-set x set)
   (cons x set))

( define ( union-set set1 set2)
   ( cond ( ( null? set1) set2)
         ( ( null? set2) set1)
         ( else ( cons ( car set2)
                      ( union-set set1 (cdr set2))))))

( define ( intersection-set set1 set2)
   ( cond ( ( or ( null? set1) ( null? set2)) null)
         ( ( element-of-set? ( car set1) set2)
           ( cons ( car set1)
                 ( intersection-set ( cdr set1) set2)))
         ( else ( intersection-set set1 (cdr set2)))))


( define set1 (list 1 2 3 4 5))
( define set2 ( list 3 4 5 6 7))

( display "element-of-set?\n")
( element-of-set? 5 set1)
( display "adjoin-set\n")
( adjoin-set 3 set2)
( display "intersection-set\n")
( intersection-set set1 set2)
( display "union-set\n")
( union-set set1 set2)