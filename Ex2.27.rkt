#lang racket

;EX 2.27

;deep-reverse version1.0

(define (deep-reverse items)
  (define (deep-rev-imp items result)
    (if (null? items) ;到list尾部后结束递归，返回结果
        result
        (let ((first (car items)))
          (deep-rev-imp (cdr items)
                        (cons (if (not (pair? first)) ;当递归的节点为叶子节点时返回first，否则递归first
                              first
                              (deep-reverse first))
                        result)))))
  (deep-rev-imp items null))

(define x (list (list 1 2) (list 3 (list 4 5))))

(define y (list(list 1 2) (list 3 4)))


(deep-reverse y)

;deep-reverse version2.0

(define (deep-reverse-2 items)
  (define (deep-rev-if-required item)
    (if (not (pair? item))
        item
        (deep-reverse-2 item)))
  
  (define (deep-rev-imp items result)
    (if (null? items)
        result
        (deep-rev-imp (cdr items)
                      (cons (deep-rev-if-required(car items))
                            result))))
  (deep-rev-imp items null))

(deep-reverse-2 y)
