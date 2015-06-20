#lang racket

;Ex 2.45
(define (split orig-placer split-placer)
  (define (rec painter n)
    (if ( = n 1)
        painter
        (let ( ( smaller ( rec painter (- n 1))))
          (orig-placer painter ( split-placer smaller smaller)))))rec)