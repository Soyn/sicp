#lang racket
;Ex2.46

(define (make-vect xcor ycor)
  (list xcor ycor))

(define (xcor-vect vector)
  (car vector))

(define (ycor-vect vector)
  (cadr vctor))

(define (add-vect vec1 vec2)
  (cons ((+ (xcor-vect vec1) (ycor-vect vec2))
         (+ (ycor-vect vec1) (ycor-vect vec2)))))