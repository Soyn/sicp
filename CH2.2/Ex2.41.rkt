#lang racket

;----------Support Function--------------------------------------
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      ( op (car sequence)
           (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (unique-pairs n)   ;生成序列(i, j)，其中j < i < n
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;----------Support Function End-------------------------------------
;------------Ex 2.41------------------------------------------------

(define (ordered-triples-sum n s)
  (filter (lambda (list) ( = (accumulate + 0 list) s))
          (flatmap
           (lambda(i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n))))

;-----------Answer Test---------------------------
(ordered-triples-sum 10 6)
(enumerate-interval 2 10)