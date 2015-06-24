#lang racket

;-------------------------support Function---------------------------------------
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

(define ( transform-painter painter origin corner1 corner2)
  (lambda (frame)
    ( let ( ( m (frame-coord-map frame)))
       (let ( (new-origin (m origin)))
         (painter
          (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))
(define (add-vect v1 v2)
  (make-vect ( + (xcord-vect v1) (xcord-vect v2))
            (+ (ycord-vect v1) (+ (ycord-vect v2)))))

(define (scale-vect vect s)
  (make-vect (* (xcord-vect vect) s)
            ( * (ycord-vect vect) s)))

(define ( frame-coord-map frame)
  (lambda (v)
    ( add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcord-vect v)
                           (edge1-frame frame))
               (scale-vect ( ycord-vect v)
                          (edge2-frame frame))))))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))
;----------------------------SP Ends---------------------------

;Ex2.50 answer

( define ( flip-horiz painter)
   ( transform-painter
     (make-vect 1.0 0.0)
     (make-vect 0.0 0.0)
     (make-vect 1.0 1.0)))

(define (rotate180 painter)
  (transform-painter painter
                    (make-vect 1.0 1.0)
                    (make-vect 0.0 1.0)
                    (make-vect 1.0 0.0)))

( define (rotate270 painter)
   (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

