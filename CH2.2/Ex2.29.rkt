#lang racket

;Ex 2.29

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch binary-mobile)
  (car binary-mobile))

(define (right-branch binary-mobile)
  (car (cdr binary-mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (structure-is-mobile? structure)
  (pair? structure))

;tests helper functions
;(left-branch (make-mobile 2 3))
;(right-branch (make-mobile 2 3))
;(branch-length (make-mobile 4 5))
;(branch-structure (make-branch 4 5))

;b: caculate the total weights

(define (branch-weight branch)  ;计算分支上的重量
  (let ((s (branch-structure branch)))
    (if (structure-is-mobile? s)  ;假如还是分支话继续向下遍历
        (total-weight s)
        s)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))


;test usage
;
;level 3:             4  |  8
;                 +------+------+2
;                 |
;level 2:       3 | 9
;           +-----+-----+ 1
;level 1: 1 | 2          
;         +-+-+
;         2   1

(define level-1-mobile (make-mobile (make-branch 2 1)
                                    (make-branch 1 2)))

(define level-2-mobile (make-mobile (make-branch 3 level-1-mobile)
                                   (make-branch 9 1)))

(define level-3-mobile (make-mobile (make-branch 4 level-2-mobile)
                                    (make-branch 8 2)))


(total-weight level-1-mobile)
(total-weight level-2-mobile)
(total-weight level-3-mobile)

