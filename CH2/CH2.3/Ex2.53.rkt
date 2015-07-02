#lang racket

;Ex 2.53
£»@Soyn

(display "(list 'a 'b 'c):\n" )
(list 'a 'b 'c)

(display "(list (list 'george)):\n")

( list ( list 'george))

(display " (cdr'((x1 x2) (y1 y2))):\n")
( cdr '( ( x1 x2) ( y1 y2)))

(display "(cadr ( (x1 x2) ( y1y2))):\n")
( cadr ' ( (x1 x2) ( y1 y2)))

(display "(pair? (car '(a short list))):\n")
( pair? ( car '( a short list)))

(display " (memq 'red '( ( red shoes) ( blue socks))):\n")
( memq 'red '( ( red shoes) ( blue socks)))

( display " (memq 'red '(red shoes blue socks)):\n")
(memq 'red '( red shoes blue socks))