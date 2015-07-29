#lang racket

;; Ex2.87
;; Created by Soyn. 29/7/15.
;; @Brief:Install =zero? for polynomials in the generic arithmetic package. This will allow
;; adjoin-term to work for polynomials with coefficients that are themselves polynomials.

;; add into polynomial package.

( define ( zero-poly? poly)
   ( define ( zero-terms? termlist)
      ( or ( empty-termlist? termlist)
          ( and ( =zero? ( coeff ( first-term termlist)))   ;; we define the `=zero?` in Ex2.80.
               ( zero-terms? ( rest-terms termlist)))))  ;; recursion the rest of terms.
   ( zero-terms? ( term-list poly)))
