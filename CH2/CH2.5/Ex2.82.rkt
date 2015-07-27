#lang racket

;; Ex2.82
;; Create by Soyn. 25/7/15
;; Show how to generalize apply-generic to handle coercion in the general case of
;; multiple arguments. One strategy is to attempt to coerce all the arguments to the type of the first argument,
;; then to the type of the second argument, and so on. Give an example of a situation where this strategy (and
;; likewise the two-argument version given above) is not sufficiently general. (Hint: Consider the case where
;; there are some suitable mixed-type operations present in the table that will not be tried.)

( define ( apply-generic op args)
   ( define ( iter type-tags args)          ;;iter returns the list of coerced argument or raise an error.
      ( if (null? type-tags)
      ( error " No method for these type-tags")
      ( let ( ( type1 ( car type-tags)))
         ( let ( ( filtered-args ( true-map ( lambda (x)
                                               ( let ( ( type2 ( type-tag x)))
                                                  ( if ( eq? type1 type2)
                                                      x
                                                      ( let ( ( t2->t1 ( get-coercion type2 type1)))
                                                         ( if ( null? t2->t1) false ( t2->t1 x))))))
                                           args)))
            ( or filtered-args
                ( iter ( cdr type-tags) args))))))
   ( let ( ( type-tags ( map type-tag args)))
      ( let ( ( proc ( get op type-tags)))
         ( if ( not ( null? proc))
             ( apply proc ( map contents args))
             ( apply apply-generic ( cons op ( iter type-tags args)))))))
