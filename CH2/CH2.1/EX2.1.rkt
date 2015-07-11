#lang racket
;exercise 2.1
;author:@Soyn

(define (number x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (number x))
  (display "/")
  (display (denom x)))

(define (make-rat n d)
  (let ((g((if(< d 0)- +)(gcd n d))))
    (cons(/ n g)(/ d g))))
