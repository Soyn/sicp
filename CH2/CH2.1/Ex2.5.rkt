#lang racket
(define (cons a b)
  (*(expt 2 a)(expt 3 b)))

;令2^a = z
;等式两边同取对数得log(2^a) = log(z)
;所以alog(2) = log(z)
;所以a = log(z)/log(2)
;同理b = log(z)/log(3)

(define (car z)
  (define (divisible-by-3? a)
    (= (remainder a 3) 0))
  (if (divisible-by-3? z)
      (car (/ z 3))
      (/ (log z) (log 2))))

(define (cdr z)
  (define (even? a)
    (= (remainder a 2) 0))
  (if (even? z)
      (cdr(/ z 2))
      (/(log z) (log 3))))

;test
(define z (cons 11 16))
(car z)
(cdr z)