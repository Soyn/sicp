#lang racket

;Ex 2.28


(define (fringe tree)
  (define (build-fringe x result)
    (cond ((null? x)result)  ;判断是否将树遍历完，if yes,返回result
          ((not (pair? x))    ;判断是不是双亲节点
           (cons x result))   ;不是双亲节点时构造序对
          (else (build-fringe (car x)
                              (build-fringe (cdr x) result)))))
  (build-fringe tree null))


;test usage

(fringe (list (list 1 2) (list 3 4)))
(fringe (list ))

