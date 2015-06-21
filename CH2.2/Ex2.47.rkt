#lang racket
;Ex2.47

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define ( frame-origin f) ( car f))
(define ( frame-edge1 f) (cadr f))
(define ( frame-edge2 f) (caddr f))

(define f (make-frame 1 2 3))
(frame-origin f)
(frame-edge1 f)
(frame-edge2 f)




(define (make-frame1 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (frame-origin1 f) (car f))
(define (frame-edge11 f) (cadr f))
(define (frame-edge22 f) (cddr f))

(define g (make-frame1 1 2 3))

(frame-origin1 g)
(frame-edge11 g)
(frame-edge22 g)

