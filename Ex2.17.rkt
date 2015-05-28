#lang racket
;Ex 2.17

(define i (list 23 72 149 34))

(define (last-pair items)
  (let((rest (cdr items)))
    (if (null? rest)
        items
        (last-pair rest))))

(last-pair i)