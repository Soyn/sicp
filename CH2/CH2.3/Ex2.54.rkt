#lang racket

;Ex 2.54

(define ( equal? s1 s2)
  ( cond ( ( and ( not ( pair? s1)) ( not ( pair? s2)))  ;判断是不是单个元素
           ( eq? s1 s2))                 ;是单个元素的话比较元素是否相等
        ( (and ( pair? s1) ( pair? s2))
          (and ( equal? ( car s1) ( car s2)) ( equal? ( cdr s1) ( cdr s2))))
        ( else false)))
;----------------------------------------------------------------------------------------------

; It's just a test
( equal? '(1 2 3 (4 5) 6) '(1 2 3 ( 4 5) 6))