#lang racket

;----------------------------------------------------
; support function
(define (filter predicate sequence) ;定义过滤器
  (cond ((null? sequence)
         null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)  ;构成low到high的一个list
  (if (> low high)                     ;例如：(enumerate-interval 1 5) ---output-----> (1 2 3 4 5) 
      null
      (cons low (enumerate-interval (+  low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (prime? x)                  ;判断给定的数是否未素数
  (define (test divisor)
    (cond ((> (* divisor divisor)x)true)  
          ((= 0 (remainder x divisor)) false)
          (else (test (+ divisor 1)))))
  (test 2))

(define (prime-sum? pair)    ;判断序对的和是否为素数
  (prime? (+ (car pair) (cadr pair))))  ;其中国cadr返回的值是cdr后的list的首元素

(define (make-sum-pair pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (make-sum-pairs n)
  (map make-sum-pair
       (filter prime-sum? (unique-pairs n))))

;-----------------------------------------------------

;the answer

(define (unique-pairs n)  ;unique-pairs给定整数n生成序列（i,j）其中 j < i <=n
  (flatmap (lambda (i)    
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))  ;enumerate-interval生成1~n的list

;test
(unique-pairs 5)
(define list1 (list 1 3 2 3 4))
(cadr list1)