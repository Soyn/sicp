#lang racket
;ex 2.4

(define (cons x y)
     (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

;test
(define x (cons 3 4))
(car x)
(cdr x)