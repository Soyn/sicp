#lang racket
;Ex 2.33

;题干条件
(define (square x)
  (* x x))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
               (accumulate op initial (cdr sequence)))))
;
(define (my-map p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              null sequence))

(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))


(define (my-length sequence)
  (accumulate (lambda(x y)
                (+ 1 y))
              0 sequence))


;test usage 

(define x (list 1 2 3))
(define y (list 4 5 6))


(my-append x y)
(my-length x)
(my-map square x)