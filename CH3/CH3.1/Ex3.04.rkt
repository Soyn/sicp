#lang racket

;; Ex3.04
;; Created by Soyn. 2/8/15.
;; Brief:Modify the make-account procedure of exercise 3.3 by adding another local state
;; variable so that, if an account is accessed more than seven consecutive times with an incorrect password, it
;; invokes the procedure call-the-cops.

( define ( make-account balance password)
   ( define ( call-the-cops) "Call the cops")
   ( let ( ( count 0)
           ( limit 7))
      ( define ( withdraw amount)
         (if ( >= balance amount)
            ( begin ( set! balance ( - balance amount))
                   balance)
            "Insufficient funds"))
      ( define ( deposit amount)
         ( set! balance ( + balance amount))
         balance)
      ( define ( dispatch pass proc)
         ( if ( not ( eq? pass password))
             ( lambda ( amount)
                ( if ( > count limit)
                    ( call-the-cops)
                    ( begin ( set! count ( + count 1))
                           "Incorrect password")))
             ( begin ( set! count 0)
                    ( cond ( ( eq? proc 'withdraw) withdraw)
                          ( ( eq? proc 'deposit) deposit)
                          ( else ( error "Unknown call -- MAKE-ACCOUNT"
                                        proc))))))
      dispatch))

