#lang racket

;; Ex3.1
;; Created by Soyn. 2/8/15.
;; @Brief:An accumulator is a procedure that is called repeatedly with a single numeric argument and
;; accumulates its arguments into a sum. Each time it is called, it returns the currently accumulated sum.
;; Write a procedure make-accumulator that generates accumulators, each maintaining an independent
;; sum. The input to make-accumulator should specify the initial value of the sum; for example
;;          (define A (make-accumulator 5))
;;          (A 10)
;;          15
;;          (A 10)
;;          25

( define ( make-accumulator num)
   ( let (( sum num))
      ( lambda (num)
         ( begin ( set! sum ( + sum num))
                sum))))

;; test

( define A ( make-accumulator 5))
( A 10)   ;; ===>10
(A 10)    ;; ===> 25
