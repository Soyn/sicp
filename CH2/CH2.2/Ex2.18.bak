#lang racket

;Ex2.18
(define (reverse items)
  (if (null? (cdr items))
      items
      (append(reverse (cdr items))
             (list (car items)))))

;test
(reverse (list 1 2 3 4))