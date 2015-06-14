#lang racket
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
               (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff accum-sum)
                (+ this-coeff
                   (* x accum-sum)))
              0
              coefficient-sequence))

;test usage
(horner-eval 2 (list 2 3 0 5 0 2))

