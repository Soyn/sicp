#lang racket
;-------------------------Support Fuction--------------------

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

( define ( make-vect x y)
   (cons x y))
(define ( xcord-vect v)
  (car v))
(define ( ycord-vect v)
  (cdr v))
( define (sub-vect v1 v2)
   (make-vect ( - (xcord-vect v1) ( xcord-vect v2))
             (- (ycord-vect v1) ( ycord-vect v2))))

(define (add-vect v1 v2)
  (make-vect ( + (xcord-vect v1) (xcord-vect v2))
            (+ (ycord-vect v1) (+ (ycord-vect v2)))))

(define ( transform-painter painter origin corner1 corner2)
  (lambda (frame)
    ( let ( ( m (frame-coord-map frame)))
       (let ( (new-origin (m origin)))
         (painter
          (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define ( frame-coord-map frame)
  (lambda (v)
    ( add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcord-vect v)
                           (edge1-frame frame))
               (scale-vect ( ycord-vect v)
                          (edge2-frame frame))))))

(define (scale-vect vect s)
  (make-vect (* (xcord-vect vect) s)
            ( * (ycord-vect vect) s)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

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

( define (rotate270 painter)
   (transform-painter painter
                     (make-vect 0.0 1.0)
                     ( make-vect 0.0 0.0)
                     ( make-vect 1.0 1.0)))

;-----------------------SP Ends------------------------------------------------------

;Ex2.51 
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

; another way 

( define (below2 painter1 painter2)
   ( rotate270 ( beside ( rotate90 painter2) ( rotate90 painter1))))