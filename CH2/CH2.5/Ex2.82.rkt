#lang racket

;; Ex2.83
;; Created by Soyn. 26/7/15
;; @Brief:Show how to generalize apply-generic to handle coercion in the general case of
;; multiple arguments. One strategy is to attempt to coerce all the arguments to the type of the first argument,
;; then to the type of the second argument, and so on. Give an example of a situation where this strategy (and
;; likewise the two-argument version given above) is not sufficiently general. (Hint: Consider the case where
;; there are some suitable mixed-type operations present in the table that will not be tried.)

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

 
