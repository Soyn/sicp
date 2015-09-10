;;
;; Exercise3.22
;; Created by Soyn.10/9/15.
;; @Brief:Instead of representing a queue as a pair of pointers, we can build a queue as a procedure
;; with local state. The local state will consist of pointers to the beginning and the end of an ordinary list.
;; Thus, the make-queue procedure will have the form
;; (define (make-queue)
;;    (let ((front-ptr ...)
;;          (rear-ptr ...))
;;          <definitions of internal procedures>
;;          (define (dispatch m) ...)
;;          dispatch))


( define ( make-queue)
   (let ( (front-ptr '())
     ( rear-ptr '()))
   ( define ( empty-queue?) ( null? front-ptr))
   ( define ( set-front-ptr! item) ( set! front-ptr item))
   ( define ( set-rear-ptr! item) ( set! rear-ptr item))
   ( define ( front-queue)
      ( if ( empty-queue?)
          ( error "FRONT called with an empty queue")
          ( car front-ptr)))
   ( define ( insert-queue! item)
      ( let ( ( new-pair ( cons item '())))
         ( cond ( ( empty-queue?)
                  ( set-front-ptr! new-pair)
                  ( set-rear-ptr! new-pair))
               ( else
                 ( set-cdr! rear-ptr new-pair)
                 ( set-rear-ptr! new-pair)))))
   ( define ( delete-queue!)
      ( cond ( ( empty-queue?)
               ( error "DELETE called with an empty queue"))
            ( else ( set-front-ptr! ( cdr front-ptr)))))
   ( define ( print-queue) front-ptr)
   ( define ( dispatch m)
      ( cond ( ( eq? m 'empty-queue) empty-queue?)
            ( ( eq? m 'front-queue) front-queue)
            ( ( eq? m 'insert-queue!) insert-queue!)
            (( eq? m 'delete-queue!) delete-queue!)
            (( eq? m 'print-queue) print-queue)
            ( else ( error "undefined operation --QUEUE" m))))
   dispatch))

;; ---------Following is a test--------------------------------------------

( define q ( make-queue))

((q 'insert-queue!)'a)
((q 'insert-queue!) 'b)

(( q 'delete-queue!))

(( q'insert-queue!) 'a)

( ( q 'print-queue)) ;; ==> ( b a)