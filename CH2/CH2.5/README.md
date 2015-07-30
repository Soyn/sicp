##Exercise2.81

> Louis Reasoner has noticed that apply-generic may try to coerce the arguments to
each other's type even if they already have the same type. Therefore, he reasons, we need to put procedures
in the coercion table to "coerce" arguments of each type to their own type. For example, in addition to the
scheme-number->complex coercion shown above, he would do:

```racket

(define (scheme-number->scheme-number n) n)

(define (complex->complex z) z)

(put-coercion 'scheme-number 'scheme-number
	scheme-number->scheme-number)
	
(put-coercion 'complex 'complex complex->complex)


```

> a. With Louis's coercion procedures installed, what happens if apply-generic is called with two
arguments of type scheme-number or two arguments of type complex for an operation that is not
found in the table for those types? For example, assume that we've defined a generic exponentiation
operation:

```racket

(define (exp x y) (apply-generic 'exp x y))

```

 and have put a procedure for exponentiation in the Scheme-number package but not in any 
 other package:
 
 ```racket
 
  ;;following added to scheme-number package 
 (put 'exp '(scheme-number scheme-number)
	(lambda (x y) (tag (expt x y)))) 	; using primitive expt
 ```
	
What happens if we call exp with two complex numbers as arguments?


`Answer.`

>a. After Louis's procedure installed. whenever apply-generic is called with two arguments of type
scheme-number or two arguments of type complex, we can not found an operation in the table. And it drops
into an infinite recursion.



b. Is Louis correct that something had to be done about coercion with arguments of the same type, or does
apply-generic work correctly as is?

`Answer.`

>Louis's modifications to the coercion can not work. If we apply his modifications, will cause the possibility
of infinite recursions.



c. Modify apply-generic so that it doesn't try coercion if the two arguments have the same type.


`Answer.`

> ##[Exercise2.81_c](Ex2.81_c.rkt)

##[Exercise2.82](Ex2.82.rkt)

##[Exercise2.83](Ex2.83.rkt)

##[Exercise2.84](Ex2.84.rkt)

##[Exercise2.85](Ex2.85.rkt)

##[Exercise2.86](Ex2.86.rkt)

`Note: `
>> To accomodate generic number in the complex package, we should replace operators such as +, *  with their generic counterparts add,mul. 


##[Project_Symbolic_Algebra](Project_Symbolic_Algebra.rkt)

##[Exercise2.87](Ex2.87.rkt)

##[Exercise2.88](Ex2.88.rkt)

##[Exercise2.89](Ex2.89.rkt)

##[Exercise2.90](Ex2.90.rkt)