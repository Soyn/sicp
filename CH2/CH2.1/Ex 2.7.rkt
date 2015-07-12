;Ex2.7
;author:@Soyn
#lang racket
(define (make-interval a b)
  (cons a b))

(define (upper-bound x)
  (max (car x) (cdr x)))

(define (lower-bound x)
  (min (car x) (cdr x)))

;;usage
(define a (make-interval 2 7))
(upper-bound a)
(lower-bound a)
