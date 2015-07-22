#lang racket

;Ex2.75
;@Brief: 
; Created by Soyn 22/7/15.

( define ( make-from-mag-ang r a)
   ( define ( dispatch op)
      ( cond ( ( eq? op 'real-part) ( * r ( cos a)))
            (( eq? op 'imag-part) ( * r ( sin a)))
            ( ( eq? op 'magnitude) r)
            ( ( eq? op 'angle) a)
            ( else ( error "Unknow op ---MAKE-FROM-MAG--ANG" op))))
   dispatch)