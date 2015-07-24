#lang racket

; Create by Soyn, 24/7/15.
; Exercise 2.79
; Define a generic equality predicate equ? that tests the equality of two numbers, and install
; it in the generic arithmetic package. This operation should work for ordinary numbers, rational
; numbers,and complex numbers.

( define ( install-scheme-number-package)
   ( put 'equ? '(scheme-number scheme-number) =)
   'done)

( define ( install-rational-package)
   ( define ( equ? x y)
      ( = ( * ( number x) ( denom y)) ( * ( number y) ( denom x))))
   ( put 'equ? '( rational rational) equ?)
   'done)


( define ( install-complex-package)
   ( define ( equ? x y)
      ( and ( = ( real-part x) ( real-part y)) ( = ( imag-part x) ( imag-part y))))
   ( put 'equ? '( complex complex) equ?)
   'done)

( define ( equ? x y) ( apply-generic 'equ? x y))