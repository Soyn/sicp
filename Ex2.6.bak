#lang racket
;ex 2.6
(define (zero)
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;我们已经知道了0和加1的操作
;那么1就是(add-1 zero)返回的结果
(define one
  (lambda (f) (lambda (x) (f x))))