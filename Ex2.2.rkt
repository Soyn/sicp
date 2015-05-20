#lang racket
;;ex 2.2
;define point
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display",")
  (display(y-point p))
  (display")"))

;define segment
(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cdr segment))
(define (midpoint-segment segment)
  (define (average a b)
    (/(+ a b)2.0))
  (let ((a (start-segment segment))
        (b (end-segment segment)))
    (make-point(average(x-point a)
                       (x-point b))
               (average(y-point a)
                       (y-point b)))))
;test
(define seg(make-segment (make-point 5 3)
                         (make-point 10 15)))

(print-point (midpoint-segment seg))