#lang racket
;! Ex 2.62
;!@Soyn
;!Given an implement of union-set using th ordering set

( define ( union-set set1 set2)
   ( cond ( (null? set1) set2)
         ( ( null? set2) set1)
         ( (= ( car set1) ( car set2))
         ( cons ( car set1) ( union-set ( cdr set1) ( cdr set2))))
         ( ( < ( car set1) ( car set2))
           ( cons ( car set1) ( union-set ( cdr set1) set2)))
         (else
          ( cons ( car set2) ( union-set set1 ( cdr set2))))))

;usage test

( define mySet1 ( list 1 2 3 7))
( define mySet2 ( list  3 4 5))

( union-set mySet1 mySet2)
