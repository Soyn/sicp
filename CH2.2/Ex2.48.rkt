#lang racket
;Ex2.48
(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment v1)
  (car v1))

(define (end-segment v2)
  (cdr v2))