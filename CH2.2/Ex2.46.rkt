#lang racket
;Ex2.46

(define (make-vect xcor ycor)
  (cons xcor ycor))

(define (xcor-vect vector)
  (car vector))

(define (ycor-vect vector)
  (cdr vector))

(define (add-vect vec1 vec2)
  (make-vect ( + (xcor-vect vec1)  (xcor-vect vec2))
            (+ (ycor-vect vec1) (ycor-vect vec2))))


(define (sub-vect vec1 vec2)
  (make-vect ( - (xcor-vect vec1) (xcor-vect vec2))
            ( - (ycor-vect vec1) (ycor-vect vec2))))

(define (scale-vect s vect)
  (make-vect ( * (xcor-vect vect) s)
            (* (ycor-vect vect) s)))


;test uasge
(define vect1 (make-vect 1 2))
(define vect2 (make-vect 3 4))
(add-vect vect1 vect2)
(sub-vect vect2 vect1)
(scale-vect 2 vect1)