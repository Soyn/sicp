#lang racket

;--------------Support Function------------------------------
(define (accumulate op initial sequence)
  (if (null? sequence)
      null
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (filter predicate sequence)
  (cond ((null? sequence)null)
         ((predicate (car sequence))
          (cons (car sequence)
                (filter predicate (cdr sequence))))
         (else (filter predicate (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define empty-board null)


;---------------Support Function Ends-------------------------

; Eight Queens

(define (queens board-size)
  (define (queen-cols k)     ;定义k列
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))   ;判断位置能否放置皇后
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  
  (queen-cols board-size))