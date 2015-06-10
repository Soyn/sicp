#lang racket

;take changes
(define (no-more? coin-values)
  (null? (cdr coin-values)
         0
         (1)))

(define (except-first-denomination items)
  (cdr (car items)))

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
