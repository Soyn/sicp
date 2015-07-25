#lang racket

;;Ex2.81_c
;;Create by Soyn. 25/7/15

( define ( apply-generic op args)
   ( define ( handle-exception type-tags)
      ( error "No method for these types:" ( list op type-tags)))
   ( let ( ( type-tags ( map type-tag args)))
      ( let ( ( proc ( get op args)))
         ( if proc
             ( apply proc ( map contents args))
             ( if ( = ( length args) 2)
                 ( let ( ( type1 ( car type-tags))
                         ( type2 ( cadr type-tags))
                         ( a1 ( car args))
                         ( a2 ( cadr args)))
                    ;; handle the same types
                    ( if ( equal? type1 type2)
                        ( handle-exception type-tags)
                        ( let ( ( t1->t2 ( get-coercion type1 type2))
                                ( t2->t1 ( get-coercion type2 type1)))
                           ( cond ( t1->t2
                                      ( apply-generic op ( t1->t2 a1) a2))
                                 ( t2->t1
                                     ( apply-generic op a1 ( t2->t1 a2)))
                                 ( else
                                   ( handle-exception type-tags))))))
                 ( handle-exception type-tags))))))


