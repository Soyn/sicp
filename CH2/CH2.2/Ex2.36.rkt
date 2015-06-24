#lang racket
;Ex 2.36

(define (accumulate op init sequence)
  (if (null? sequence)
     init
     (op (car sequence)
        (accumulate op init (cdr sequence)))))

(define (select-cars sequences)
  (map car sequences))

(define (select-cdrs sequences)
  (map cdr sequences))

;test
(define t (list (list 1 2 3) (list 40 50 60) (list 700 800 900)))

(select-cars t)
(select-cdrs t)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
     null
     (cons (accumulate op init  (select-cars seqs))
          (accumulate-n op init  (select-cdrs seqs)))))


(accumulate-n + 0 t)