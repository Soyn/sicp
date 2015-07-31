#lang racket

;; Ex2.93
;; Created by Soyn. 31/7/15

( define ( greatest-common-divisior a b)
   ( apply-generic 'greatest-common-divisor a b))

( put 'greatest-common-divisor '( scheme-number scheme-number)
     ( lambda ( a b) ( gcd a b)))

( define ( remained-terms p1 p2)
   ( cadr ( div-terms p1 p2)))   ;;return quotient

( define ( gcd-terms a b)
   ( if ( empty-termlist? b)
       a
       ( gcd-terms b ( remainder-terms a b))))

( define ( gcd-poly p1 p2)
   ( if ( same-variable? ( variable p1) ( variable p2))
       ( make-poly ( variable p1)
                  ( gcd-terms ( term-list p1)  ;; recurison
                             ( term-list p2))
                  ( error " not in the same variable --GCD-POLY" ( list p12p)))))

( put 'greatest-common-divisor '( polynimial polynomial)
     ( lambda( a b) ( tag ( gcd-poly a b))))