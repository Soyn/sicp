#lang racket
;Ex 2.37

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (select-cars seq)
  (map car seq))
(define (select-cdrs seq)
  (map cdr seq))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
             null
             (cons (accumulate op init (select-cars seqs))
                   (accumulate-n op init (select-cdrs seqs)))))

(define matrix (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;test dot-product
(dot-product (list 1 2 3) (list 4 5 6))


(define (matrix-*-vector m v)
  (map (lambda (m-row) (dot-product m-row v)) m))

;test matrix-*-vector

(matrix-*-vector matrix (list 1 2 3 4))

(define (transpose mat)
  (accumulate-n cons null mat))

(transpose matrix)

(define (matrix-*-matrix m n)
  (let ((n-cols (transpose n)))
    (map (lambda(m-row)
           (matrix-*-vector n-cols m-row))
         m)))

;test matrix-*-matrix

(matrix-*-matrix matrix (list(list 1 2) (list 1 2)(list 1 2)(list 1 2)))