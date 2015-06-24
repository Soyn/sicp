#lang racket
;Ex 2.35
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map(lambda(node)   
                       (if (pair? node) ;不是叶子节点时递归调用count-leaves
                           (count-leaves node)
                           1))         ;是叶子节点时返回1
                      t)))

(define tree(list 1 2 (list 3 4) (list 5 (list 6 7))))

(count-leaves tree)

