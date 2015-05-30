#lang racket

;take changes
(define (no-more? items)
  (null? items))


(define (except-first-denomination items)
  (cdr  items))

(define (first-denomination items)
  (car items))


(define (cc amount coin-values)
  (cond ((= amount 0)1)
        ((or (< amount 0) (no-more? coin-values))0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

;;test usage

(define us-coins (list 50 25 10 5 1))
(cc 100 us-coins)