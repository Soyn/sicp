#lang racket

;; Ex2.88
;; Created by Soyn. 29/7/15.
;; @Brief: Extend the polynomial system to include subtraction of polynomials. (Hint: You may find
;; it helpful to define a generic negation operation.)

( define ( negate-terms termlist)
   ( map
     ( lambda(t) ( make-term ( order t)
                            ( - ( coeff t))))
     termlist))
