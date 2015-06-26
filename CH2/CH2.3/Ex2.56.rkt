#lang racket

;Ex2.56
;-----------------------Support Fuction---------------------------
( define ( variable? x) ( symbol? x))

( define ( same-variable? v1 v2)
   ( and ( variable? v1) ( variable? v2) ( eq? v1 v2)))

( define ( make-sum a1 a2)
   ( cond ( ( = number? a1 0) a2)
         ( ( = number? a2 0) a1)
         ( ( and (number? a1) ( number? a2)) ( + a1 a2))
         ( else ( list '+ a1 a2))))

(define ( make-product m1 m2)
  ( cond ( ( or (=number? m1 0) (=number? m2 0)) 0)
        ( ( =number? m1 1) m2)
        ( ( =number? m2 1) m1)
        ( ( and ( number? m1) ( number? m2)) ( * m1 m2))
        ( else ( list '* m1 m2))))

( define ( =number? exp num)
   ( and ( number? exp) ( = exp num)))

( define (sum? x)
   ( and ( pair? x) ( eq? ( car x) '+)))

( define ( addend s) ( cadr s))

( define ( augend s) ( caddr s))

( define ( product? x)
   ( and ( pair? x) ( eq? ( car x) '*)))

( define ( multiplier p) ( cadr p))

( define ( multiplicand p) ( caddr p))
;---------------------------------------------------------------------------------------------------------------------------

( define ( exponentiation? exp) ;判断表达式是不是幂
   ( and ( pair? exp) ( eq? ( car exp) '**)))


( define ( base exp) ;获得底数
   ( cadr exp))

( define ( exponent exp)
   ( caddr exp)) ;获得指数

( define ( make-exponentiation base exp)
   ( cond ( ( =number? base 1) 1)
         ( ( = number? exp 1) base)
         ( ( = number? exp 0) 1)
         ( else
           ( list '** base exp))))

( define ( deriv exp var)      
   ( cond ( ( number? exp) 0)  ;数的导数是0
         ( ( variable? exp)
           ( if ( same-variable? exp var) 1 0))
         ( ( sum? exp)   ;判断表达式是不是和式，是和式的话按照和式的求导法则运算
           ( make-sum ( deriv ( addend exp) var)
                     ( deriv ( augend exp) var))
           (( product? exp)    ;判断是不是乘式，若是按照乘式的法则求导
            ( make-sum
              ( make-product ( multiplier exp)
                            ( deriv ( multiplicand exp) var))
              ( make-product ( deriv ( multiplier exp )var)
                                    ( multiplicand exp))))
            ( exponentiation? exp)   ;判断是不是幂，是幂按照幂的求导法则
            ( make-product
              ( make-product ( exponent exp)
                            ( make-exponentiation ( base exp)
                                               ( if ( number? ( exponent exp))
                                               ( - ( exponent exp) 1)
                                               ( ' ( - ( exponent exp) 1)))))
            ( deriv ( base exp) var)))
         (else
          ( error " unknown expression type-------DERIV" exp))))
