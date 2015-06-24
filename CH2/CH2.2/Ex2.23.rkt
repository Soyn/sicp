#lang racket
;Ex 2.23

(define (for-each proc items)
  (proc (car items))
  (if (null? (cdr items))
      (newline)
      (for-each proc (cdr items))))


;;test usage

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))