#lang racket

;; Ex2.83
;; Created by Soyn. 26/7/15
;; @Brief:Suppose you are designing a generic arithmetic system for dealing with the tower of types
;; shown in figure 2.25: integer, rational, real, complex. For each type (except complex), design a procedure
;; that raises objects of that type one level in the tower. Show how to install a generic raise operation that
;; will work for each type (except complex).

( define ( integer->rational integer)
   ( make-rational integer 1))

( define ( rational->real rational)
   ( define ( integer->floating-point integer)
      ( * integer 1.0))
   ( make-real ( / ( integer->floating-point ( number rational))
                  ( denom rational))))

( define ( real->complex real)
   ( make-complex-from-real-img real 0))

;; put them in coersion table

( put-coersion 'integer 'rational integer->rational)
( put-coersion 'rational 'real ration->real)
( put-coersion 'real 'complex real->complex)

( define ( raise number)
   ( define tower '( integer rational real complex)) ;define a types tower
   ( define ( try tower)             ;go through the types-tower
      ( if ( < ( length tower) 2)
          ( error "Couldn't raise type" number)
          ( let ( ( current-type ( car tower))
                  ( next-types ( cdr tower))
                  ( next-type ( car next-types)))
             ( if ( eq? ( type-tag number) current-type)    
                 ( ( get-coersion current-type next-type) number)
                 ( try next-types)))))
   ( try tower))

 
