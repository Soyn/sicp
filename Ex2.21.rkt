#lang racket
;Ex2.21

(define (square x) ;递归过程实现
  (* x x))

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))
            (square-list (cdr items)))))

(display "递归版本！！！！")

(square-list (list 1 2 3 4))

(display "map版本!!!!!!!")

(define (map-square-list items)
  (map (lambda (x) (* x x))
       items))

(map-square-list (list 1 2 3 4))
