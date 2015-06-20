#lang racket
( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

( paint einstein)
( paint ( flip-vert einstein))  ;flip-vert 是将图片颠倒

(define (flipped-pairs painter)  
  (let ( ( painter2 (beside painter (flip-vert painter))))  ;beside将第一个画家放在框架的左边一半，将第二个画家放在框架中右边的一半
    (below painter2 painter2)))          ;below是将第一个画家放在第二个画家的下面

( paint ( flipped-pairs einstein))

(define  (right-split painter n)   ;将图片向通过递归向右边扩展
  ( if ( = n 0)
      painter
      (let ((smaller ( right-split painter ( - n  1))))
        (beside painter ( below smaller smaller)))))

(paint ( right-split einstein 3))

(define (up-split painter n)
  (if (= n 0)
     painter
     (let (( smaller (up-split painter (- n 1))))
       (below painter (beside smaller smaller)))))

(define ( corner-split painter n)
  ( if ( = n 0)
      painter
      (let ( ( up ( up-split painter ( - n 1)))
             (right ( right-split painter (- n 1))))
        (let ( ( top-left (beside up up)) 
               (bottom-right ( below right right))
               (corner ( corner-split painter ( - n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

( paint (corner-split einstein 1))