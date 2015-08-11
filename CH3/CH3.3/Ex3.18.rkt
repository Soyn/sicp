
;; Exercise 3.18
;; Created by Soyn. 11/8/15
;; @Brief:rite a procedure that examines a list and determines whether it contains a cycle, that is,
;; whether a program that tried to find the end of the list by taking successive cdrs would go into an infinite
;; loop. Exercise 3.13 constructed such lists.
;; Answer: we set a list named identity, we go through the list, when we car the list, then we use the procesure
;; `eq?` to judge, if eq, we get a loop, else we have to recurison or return false until we get null.
( define ( loop? lst)
   ( let ( ( identity ( cons '() '())))
      ( define ( iter remain-list)
         ( cond ( ( null? remain-list)
                  false)
               ( ( eq? identity ( car remain-list))
                 true)
               ( else
                 ( set-car! remain-list identity)
                 ( iter ( cdr remain-list)))))
      ( iter lst)))