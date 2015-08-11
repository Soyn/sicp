#lang racket

;; Ex3.17
;; Created by Soyn.11/8/15.
;; @Brief:Devise a correct version of the count-pairs procedure of exercise 3.16 that returns the
;; number of distinct pairs in any structure. (Hint: Traverse the structure, maintaining an auxiliary data
;; structure that is used to keep track of which pairs have already been counted.)

( define ( count-pairs x)
   ( let ( ( encountered '()))
      ( define ( helper x)
         ( if ( or ( not (pair? x)) ( memq x encountered))
         0
         ( begin
            ( set! encountered ( cons x encountered))
            ( + ( helper ( car x))
               ( helper ( cdr x))
               1))))
   ( helper x)))