#lang racket
;Ex 2.49
(require (lib "racket/draw"))
(require racket/class)
(define target (make-bitmap 100 100))
(define dc (new bitmap-dc% [bitmap target]))
;----------support function---------------------------------------------------
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda ( segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))
(define (make-segment v1 v2)
  (cons v1 v2))
(define (make-vect x y)
  (cons x y))
(define (draw-line v1 v2)
  (send dc draw-line
       (xcord-vect v1) (ycord-vect v1)
       (xcord-vect v2) (ycord-vect v2)))
(define (start-segment v1)
  (car v1))

(define (end-segment v2)
  (cdr v2))

(define (xcord-vect vect)
  (car vect))

(define (ycord-vect vect)
  (cdr vect))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcord-vect v)
                          (edge1-frame frame))
              (scale-vect (ycord-vect v)
                         (edge2-frame frame))))))

(define (add-vect v1 v2)
  (make-vect ( + (xcord-vect v1) (xcord-vect v2))
            (+ (ycord-vect v1) (+ (ycord-vect v2)))))

(define (sub-vect v1 v2)
  (make-vect ( - (xcord-vect v1) (xcord-vect v2))
            (- (ycord-vect v1) (ycord-vect v2))))

(define (scale-vect vect s)
  (make-vect (* (xcord-vect vect) s)
            ( * (ycord-vect vect) s)))

;---------------------------------------------------------------------------------------

(let ( (tl ( make-vect 0 1))
       (tr (make-vect 1 1))
       (bl (make-vect 0 0))
       (br (make-vect 1 0)))
  (segments->painter (list  ;problem a)'s solution
                      (make-segment bl tl)
                      (make-segment tl tr)
                      (make-segment tr br)
                      (make-segment br bl)))
  (segment->painter (list      ;problem b)'s solution
                     (make-segment tl br)
                     (make-segment tr bl))))

(let ( ( l (make-vect 0 0.5))
       ( t ( make-vect 0.5 1))
       (r (make-vect 1 0.5))
       (b (make-vect 0.5 0)))
  (segment-painter (list 
                    (make-segment l t)
                    (make-segment t r)
                    (make-segment r b)
                    (make-segment b l))))
