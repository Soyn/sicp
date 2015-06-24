#lang racket
;Ex 2.39

(define(accumulate op init seqs)
  (if (null? seqs)
      init
      (op (car seqs)
          (accumulate op init (cdr seqs)))))

(define (fold-right op init sequence)
  (if (null? sequence)
      init
      (op (car sequence)
          (accumulate op init (cdr sequence)))))

(define (fold-left op init sequence)
  (define (iter result rest)
  (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter init sequence))


(define (reverse-using-right sequence)
  (fold-right (lambda(first already-reversed)
                (append already-reversed (list first)))
              null
              sequence))

(define (reverse-using-left sequence)
  (fold-left (lambda (result first) (cons first result))
             null
             sequence))


;test usage

(define my-list (list 1 2 3 4))
(reverse-using-left my-list)
(reverse-using-right my-list)