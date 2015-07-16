#lang racket
;;Ex:2.10
;@Soyn
(define (make-interval a b)
  (cons a b))

(define (upper-bound x)
  (max (car x) (cdr x)))

(define (lower-bound x)
  (min (car x) (cdr x)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (upper-bound y)))
        (p2 (* (lower-bound x) (lower-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4 )
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if ( >= 0 (* (lower-bound y) (upper-bound y)))
      (error "Division error (interval spans 0)" y)
      (mul-interval x
                    (make-interval (/ 1. (upper-bound y))
                                   (/ 1. (lower-bound y))))))

(define (print-interval name i)
  (newline)
  (display name)
  (display ":[")
  (display (lower-bound i))
  (display ",")
  (display (upper-bound i))
  (display "]"))


;;test

(define span-0 
  (make-interval -1 1))

(define i (make-interval 2 7))
(define j (make-interval 3 8))
(print-interval "i/j" (div-interval i j))
(newline)
(print-interval "i/span-0" (div-interval i span-0))
