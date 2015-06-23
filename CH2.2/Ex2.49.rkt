#lang racket
;Ex 2.49
(require (lib "racket/draw"))
(require racket/class)
(define target (make-bitmap 100 100))
(define dc (new bitmap-dc% [bitmap target]))

;----------support function---------------------------------------------------


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

;---------------------------------------------------------------------------------------

;;a
(define a-painter (segments->painter
                    (list (make-segment
                               (make-vect 0 0)
                               (make-vect 0 1))
                               (make-segment
                               (make-vect 0 1)
                               (make-vect 1 1))
                               (make-segment
                                (make-vect 1 1)
                                (make-vect 1 0))
                                (make-segment 
                                 (make-vect 1 0)
                                 (make-vect 0 0)))))

; b
(define b-painter ( segments->painter 
                    ( list (make-segment 
                            (make-vect 0 0)
                            (make-vect 1 1))
                          (make-segment
                           ( make-vect 0 1)
                           (make-segment 1 0)))))


;c

( define c-painter (segments->painter 
                    (list ( make-segment 
                            (make-vect 0 0.5)
                            (make-vect 0.5 0))
                            (make-segment
                             (make-vect 0.5 0)
                             (make-vect 1 0.5))
                             (make-segment
                              (make-vect 1 0.5)
                              (make-vect 0.5 1))
                             (make-segment
                              (make-vect 0.5 1)
                              (make-vect 0 0.5)))))
;d