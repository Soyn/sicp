#lang racket
;Ex 2.31

(define (square x)
  (* x x))

(define (tree-map proc tree)
  (map (lambda(sub-tree)
         (if (pair? sub-tree)
         (tree-map proc sub-tree)
         (proc tree)))
       tree))


(define (square-tree tree)
  (tree-map square tree))


;usage test

(define testTree 
  (list 1
        (list 2(list 3 4)5)))

(square-tree testTree)