#lang racket


;Ex 2.30

;not map

(define (square x)
  (* x x))

(define (square-tree tree)
  (cond ((null? tree)
         null)
        ((not (pair? tree))(square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

;use map
(define (map-square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (map-square-tree sub-tree)
             (square sub-tree)))
       tree))

;test usage

(define testTree
  
  (list 1
        (list 2(list 3 4)5)))

(square-tree testTree)

(map-square-tree testTree)