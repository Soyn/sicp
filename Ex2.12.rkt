#lang racket
(define (make-interval x y)
  (cons x y))

(define (upper-bound x)
  (max (car x) (cdr x)))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (center i) (/ (+ (upper-bound i) (lower-bound i)) 2))


;define percent

(define (make-center-percent c pct)
  (let ((width (* c (/ pct 100.0))))
    (make-interval (- c width) (+ c width))))

(define (percent-tolerance i)
  (let ((center (/ (+ (upper-bound i) (lower-bound i)) 2.0))
        (width (/ (- (upper-bound i) (lower-bound i)) 2.0)))
    (*(/ width center) 100)))

(define i (make-center-percent 10 50))

(lower-bound i)
(upper-bound i)
(center i)
(percent-tolerance i)
