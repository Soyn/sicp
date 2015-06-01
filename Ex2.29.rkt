#lang racket

;Ex 2.29

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch binary-mobile)
  (car binary-mobile))

(define (right-branch binary-mobile)
  (cdr binary-mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))


(define (total-weight items)
  (if (null? items)
      0
      (+ 1 (total-weight (left-branch))
         (total-weight (right-branch))
         )))

;test usage

(total-weight (list 1(list 2 3)))