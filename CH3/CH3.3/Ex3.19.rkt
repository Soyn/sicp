
;;Exercise3.19
;; Created by Soyn. 11/8/15.
;; @Brief:Redo exercise 3.18 using an algorithm that takes only a constant amount of space. (This
;; requires a very clever idea.)
;; Answer: we can set two points, one point goes to next node with one step every time, another point goes
;; two step, if they met, we get a loop. 

( define ( loop? lst)
   ( define ( iter x y)
      ( let ( ( x-walk ( list-step 1 x))
              ( y-walk ( list-step 2 y)))
              ( cond ( ( or ( null? x-walk) ( null? y-walk))
                       #false)
                    (( eq? x-walk y-walk)
                     #true)
                    ( else
                      ( iter x-walk y-walk)))))
      ( iter lst lst))

( define ( list-step step lst)
   ( cond ( ( null? lst)
            '())
         ( ( = step 0)
           lst)
         (else
          ( list-step ( - step 1)
                     ( cdr lst)))))

( loop? ( list 1 2 3))