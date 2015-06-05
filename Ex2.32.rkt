#lang racket
;Ex2.32

;该问题类似于换零钱的问题
;可以将问题归约为两种情况：
;***** 1.将集合的第一个元素除开
;***** 2.在排除掉第一个元素的集合中，重新插入第一个元素
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))
;test

(subsets (list 1 2 3))

;其递归过程为:
;(subsets '(1 2 3))
;rest ← (subsets '(2 3))
;       rest ← (subsets '(3))
;              rest ← (subsets '())
;                     '(())
;     (append '(()) (map ⟨...⟩ '(())))
;              '(() (3))
;       (append '(() (3)) (map ⟨…⟩ '(() (3))))
;       '(() (3) (2) (2 3))
;(append '(() (3) (2) (2 3)) (map ⟨…⟩ '(() (3) (2) (2 3))))
;'(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))