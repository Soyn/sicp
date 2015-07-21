#lang racket


;Ex2.73
;Created by Soyn. 21/7/15

;---------------Help Fuction---------------
;PS:Assume get/put procedurehas existed..
( define ( type-tag datum)
   ( if ( pair? datum)
       ( car datum)
       ( error " Bad tagged datum -- TYPE-TAG" datum)))

( define ( attach-tag type-tag contents)
   ( cons type-tag contents))

( define ( apply-generic op args)
   ( let ( ( type-tags ( map type-tag args)))
      ( let ( ( proc ( get op type-tags)))
         ( if proc
             ( apply proc ( map contents args))
             ( error 
               "No method for these types -- APPLY-GENERIC"
               ( list op type-tags))))))

( define ( deriv exp var)
   ( cond ( ( number? exp) 0)
         ( ( variable? exp) ( if ( same-variable? exp var) 1 0))
         ( else ( ( get 'deriv ( operator exp)) ( operands exp)
                                               var))))
( define ( operator exp) ( car exp))
( define ( operands exp) ( cdr exp))
;------------------------------------------------
;;     b solutions:
( define ( install-sum-package)
   ( define ( make-sum a1 a2) ( cons a1 a2))
   ( define ( addend s) ( cadr s))
   ( define ( augend s) ( caddr s))
   ( define ( deriv-sum s)
      ( make-sum ( deriv ( addend s)) ( deriv ( augend s))))
      ( define ( tag x) ( attach-tag '+ x))
      ( put 'deriv '(+) deriv-sum)   ;put the deriv into the dispatch
      ( put'make-sum '+
           ( lambda ( x y) ( tag ( make-sum x y))))
      'done)

   ( define ( make-sum x y)
      ( ( get 'make-sum '+) x y))
   
   ( define ( install-product-package)
      ( define ( make-profuct m1 m2) ( cons m1 m2))
      ( define ( multiplier p) ( cadr p))
      ( define ( multiplicand p) ( caddr p))
      ( define ( deriv-product p)
         ( make-sum
           ( make-product ( multiplier exp)
                         ( deriv ( multiplicand exp) var))
           ( mkae-product ( deriv ( multiplier exp) var)
                         ( multiplicand exp))))
      ( define ( tag x) ( attach-product '* x))
      ( put 'deriv '(*) deriv-product)
      ( put 'make-product '*
           ( lambda ( x y) ( tag ( make-product x y))))
      'done)
   
  ( define ( make-product x y)
     ( ( get 'make-product '*) x y))
  
  ( define ( deriv x) ( apply-generic 'deriv x))
  
  
  ;; c solution:
  
  ( define ( exponentation-deriv exp var)
     ( make-product ( exponent exp)
                   ( make-product
                     ( make-exponentation ( base exp)
                                         ( make-sum ( exponent exp) -1))
                     ( deriv ( base exp) var))))
  
  ( define ( exponent exp)
     ( cadr exp))
  
  ( define ( base exp)
     ( car exp))
  
  ( define ( make-exponentation base exponent)
     ( cond ( ( =number? exponent 0) 1)
           ( ( number? exponent 1) base)
           ( ( number? base 1)1)
           ( else ( list '** base exponent))))
  ( put 'deriv '** exponentation-deriv)
  