##Excercise2.73
>`Exercise 2.73. Section 2.3.2 described a program that performs symbolic differentiation:


```racket
(define (deriv exp var)
  (cond ((number? exp) 0)
  
((variable? exp) (if (same-variable? exp var) 1 0))
((sum? exp)

(make-sum (deriv (addend exp) var)
          (deriv (augend exp) var)))
((product? exp)
(make-sum
 (make-product (multiplier exp)
               (deriv (multiplicand exp) var))
 (make-product (deriv (multiplier exp) var)
               (multiplicand exp))))
<more rules can be added here>
(else (error "unknown expression type -- DERIV" exp))))
```
We can regard this program as performing a dispatch on the type of the expression to be differentiated. In
this situation the ``type tag'' of the datum is the algebraic operator symbol (such as +) and the operation
being performed is deriv. We can transform this program into data-directed style by rewriting the basic
derivative procedure as

```racket
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
```
a. Explain what was done above. Why can't we assimilate the predicates number? and samevariable?
into the data-directed dispatch?

>>If an expression is a number or variable, we cannot apply procedure operator to it. 
Thus, we cannot assimilate the predicates number? andsame-variable? into the data-directed dispatch.

`
