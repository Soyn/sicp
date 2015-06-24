#lang racket

;----------------------------------------------------
; support function
(define (filter predicate sequence)
  (cond ((null? sequence)null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+  low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (prime? x)
  (define (test divisor)
    (cond ((> (* divisor divisor)x)true)
          ((= 0 (remainder x divisor)) false)
          (else (test (+ divisor 1)))))
  (test 2))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-sum-pair pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (make-sum-pairs n)
  (map make-sum-pair
       (filter prime-sum? (unique-pairs n))))

;-----------------------------------------------------

;the answer

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

;test
(unique-pairs 5)