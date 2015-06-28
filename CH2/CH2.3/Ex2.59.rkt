#lang racket

;Ex2.59
;!判断元素是不是属于集合
( define ( element-of-set? x set)
   ( cond ( ( null? set) #f)
         ( ( equal? x ( car set)) #t)
         ( else( element-of-set? x ( cdr set)))))

;向已有集合中添加元素
( define ( adjoin-set x set)
   ( if ( element-of-set? x set)
       set
       ( cons x set)))

;求两个集合的交集

( define ( intersection-set set1 set2)
   ( cond ( (or ( null? set1) ( null? set2)) null)
         ( ( element-of-set? ( car set1) set2)
           ( cons ( car set1)
                 ( intersection-set ( cdr set1) set2)))
         ( else ( intersection-set (cdr set1) set2))))

;求两个集合的并集
( define ( union-set set1 set2)
   ( cond ( ( null? set1) set2)
         ( ( null? set2) set1)
         (( element-of-set? ( car set2) set1)
          ( union-set set1 (cdr set2)))
         (else ( cons ( car set2)
                     ( union-set set1 ( cdr set2))))))
;test usage

( define x (list 1 2 3 4 5))
( define y ( list 4 5 6))

( union-set y x)
(element-of-set? 5 x)
(intersection-set x y)