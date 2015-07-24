#lang racket

; Create by Soyn, 24/7/15.
; Define a generic predicate =zero? that tests if its argument is zero, and install it in the
; generic arithmetic package. This operation should work for ordinary numbers, rational numbers
; and complex numbers.

( define ( install-scheme-number-package)
   ( put '=zero? 'scheme-number ( lambda ( x) ( = x 0))))


( define ( install-rational-package)
   ( put '=zero? 'rational-number
        ( lambda (x) ( = ( number x) 0))))

( define ( install-complex-package)
   ( put '=zero? 'complex-number
        ( lambda (x) ( = ( real-part x) ( imag-part x) 0))))