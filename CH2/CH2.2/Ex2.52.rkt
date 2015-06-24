#lang racket
(require (lib "racket/draw"))
(require racket/class)
(define target (make-bitmap 100 100))
(define dc (new bitmap-dc% [bitmap target]))
;----------Support Fuction---------------------------------------
(define (make-segment v1 v2)
  (cons v1 v2))

(define (make-vect x y)
  (cons x y))

(define (draw-line v1 v2)
  (send dc draw-line
       (xcord-vect v1) (ycord-vect v1)
       (xcord-vect v2) (ycord-vect v2)))

(define (start-segment v1) ;线段起点的X坐标
  (car v1))

(define (end-segment v2) 
  (cdr v2))

(define (xcord-vect vect)
  (car vect))

(define (ycord-vect vect)
  (cdr vect))


(define (add-vect v1 v2)
  (make-vect ( + (xcord-vect v1) (xcord-vect v2))
            (+ (ycord-vect v1) (+ (ycord-vect v2)))))

(define (sub-vect v1 v2)
  (make-vect ( - (xcord-vect v1) (xcord-vect v2))
            (- (ycord-vect v1) (ycord-vect v2))))

(define (scale-vect vect s)
  (make-vect (* (xcord-vect vect) s)
            ( * (ycord-vect vect) s)))
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define (frame-coord-map frame)         ;建立框架的坐标映射
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcord-vect v)
                          (edge1-frame frame))
              (scale-vect (ycord-vect v)
                         (edge2-frame frame))))))

(define (segments->painter segment-list)   ;wave画家
  (lambda (frame)
    (for-each
     (lambda ( segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define ( rotate90 painter)
                  (transform-painter painter
                                    (make-vect 1.0 0.0)
                                    (make-vect 1.0 1.0)
                                    (make-vect 0.0 0.0)))

(define (below painter1 painter2)
  (let ( ( split-point ( make-vect 0.0 0.5)))
    ( let ( ( paint-bottom
              (transform-painter painter1
                                (make-vect 0.0 0.0)
                                (make-vect 1.0 0.0)
                                split-point))
              ( paint-top
                ( transform-painter painter2
                                   split-point
                                   ( make-vect 1.0 0.5)
                                   ( make-vect 0.0 1.0))))
       ( lambda ( frame)
          ( paint-bottom frame)
          (paint-top frame)))))

(define ( transform-painter painter origin corner1 corner2)
  (lambda (frame)
    ( let ( ( m (frame-coord-map frame)))
       (let ( (new-origin (m origin)))
         (painter
          (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (beside painter1 painter2)
  (let ( ( split-point  ( make-vect 0.5 0.0)))
    ( let ( ( paint-left
              (transform-painter painter1
                                (make-vect 0.0 0.0)
                                split-point
                                ( make-vect 0.0 1.0)))
            ( paint-right 
              (transform-painter painter2
                                split-point
                                ( make-vect 1.0 0.0)
                                (make-vect 0.5 1.0))))
       ( lambda (frame)
          (paint-left frame)
          ( paint-right frame)))))
;----------SP Ends---------------------------------------------------
; answer of a
( define  wave 
           (segments->painter (list
                              ( make-segment ( make-vect 0.44 0.7) ( make-vect 0.51 0.7)))))
   
;answer of b

( define ( corner-split painter n)
   ( if ( = n 0)
       painter
       ( beside ( below painter ( up-split painter (- n 1)))
               (below ( right-split painter (- n 1)) ( corner-split painter (- n 1))))))

