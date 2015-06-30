#lang racket
;Ex2.61

( define ( adjoin-set x set)
   ( cond ( ( null? set) ( list x))
         ( ( = x ( car set)) set)
         ( ( < x ( car set)) ( cons x set))
         ( else ( cons ( car set) ( adjoin-set x ( cdr set))))))  


;usage test

( define myset (list 1 2 3 5 6 7))

(adjoin-set 4 myset)