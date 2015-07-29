#lang racket

;; Ex2.89
;; Created by Soyn. 29/7/15
;; @Brief: Define procedures that implement the term-list representation described above as
;; appropriate for dense polynomials.

( define ( first-term term-list)
   ( list ( car term-list) ( - ( length term-list) 1)))

( define ( adjoin-term term term-list)
   
   ( let ( ( exponent ( order term))
           ( len ( length term-list)))
      
      ( define ( iter-adjoin times terms)
         ( cond ( ( =zero? ( coeff term))   ;; get the coefficient o term
                  terms))
         ( ( = exponent times)
           ( cons ( coeff term) terms))
         ( else ( iter-adjoin ( + times 1)
                             ( cons 0 terms))))
      ( iter-adjoin len term-list)))