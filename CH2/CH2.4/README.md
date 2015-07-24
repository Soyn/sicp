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
b. Write the procedures for derivatives of sums and products, and the auxiliary code required to install
them in the table used by the program above.



c. Choose any additional differentiation rule that you like, such as the one for exponents (exercise 2.56),
and install it in this data-directed system.


d. In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it
together. Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line in
deriv looked like
```racket

((get (operator exp) 'deriv) (operands exp) var)

```

What corresponding changes to the derivative system are required?


>>the only thing is to change the order fo arguments in procedure `put`


##Exercise2.74

> Note: We assume we have a table which has a horizontal axis of division name (type) and a vertical axis of procedure.

> a.Implement for headquarters a get-record procedure that retrieves a specified employee's record
from a specified personnel file. The procedure should be applicable to any division's file. Explain how the
individual divisions' files should be structured. In particular, what type information must be supplied?

>> `a solution: ` Each division's records consisit of a single file, which contain a set of records keyed on employee's name. This single
file should be a structred as a list of employee's records. with a tag of the division name. And each employee's record should
have a tag of their name. The way these tags are put must be supplied. E.g. the file of division-1 can be '( division-1 (Rose 2000) (Mike 1500))
Here is the corresponding answer:


```racket
( define ( install-division-1-package)
   ( define ( get-record name file)
      ( cond ( ( null? file) ( error "no result"))
            ( ( eq? name ( get-name ( cadr file))) ( cons ( cadr file) ; if the division's name equals, then go on.
                                                         ( get-record name ( cdr file))))
            ( else ( get-record name ( cdr file)))))
   ( define ( get-name record)
      ( car record))
   ( put 'get-record name file)
   ( apply-generic 'division-1 get-name)'done)

( define ( get-record name file)
   ( apply-generic 'get-record name file))

( define ( apply-generic op name file)
   ( let ( ( division-name ( type-tag file)))
      ( let (( proc ( get op division-name)))
      ( if proc
          ( proc name file)
          ( error "No Result")))))

( define ( type-tag file)
   ( car file))


```

> b. Implement for headquarters a get-salary procedure that returns the salary information from a given
Download at www.Pin5i.Com
employee's record from any division's personnel file. How should the record be structured in order to make
this operation work?

> `b solution: ` We only need to modify the 'a solution' , which add a few lines:


```racket

( define ( get-salary name file)
   ( cond ( ( null? file) ( error "No Result"))
         ( ( eq? name ( get name ( cadr file))) ( cons ( cadr ( cadr file))
                                                      ( get-salary name ( cdr file))))
         ( else ( get-salary name ( cdr file)))))

( define ( get-salary name file)
   ( apply-generic 'get-salary name file))

```

> c. Implement for headquarters a find-employee-record procedure. This should search all the
divisions' files for the record of a given employee and return the record. Assume that this procedure takes
as arguments an employee's name and a list of all the divisions' files.

>> `c solution: ` We need to implement `get-record` to all divisions.

```racket

( define ( find-employee-record name list)  ;the list consists of all-division names.
   ( if (null? list)
   ( error "No Result")
   ( append ( get-record ( car list))
           ( find-employee-record name ( cdr list)))))

```

> d. When Insatiable takes over a new company, what changes must be made in order to incorporate the new
personnel information into the central system?

>> `d solution: ` We can install a new package which specifies the procedures to look up name/salary in the new
company;s file.

##[Excercise2.75](Ex2.75.rkt)
##Exercise2.76

> exercise2.76

>>  `Solution: `

The question asks us to consider three ways of handling generic operation:
			
	1. Explicit Dispatch(i.e. , Disptatching on Type)
	2. Data-Directied Style
	3. Message-Passing Style.
			
			
	The first two techniques are similar in the sense that could be descibed as " intelligent operation", where knowledge of and the 
	logic pertaining to the generic type set is maintained in method/procedures/functions described to accept generic types as arguments.
	Specifically, first, the procedure is invoked with a generic type as argument; then the procedure parses the specific type of the argument;
	and finally based on the specific type, different actions are undertaken by the procedure.
			
	But the the third technique differ from first two, i described details below.
			
	Message-Passing Style, could be described an "intelligent object" style of design, where the knowledge of and logic operating to the generic type
	set is maintained in the generic object itself. In this model, the data object itself receives the requested operation name as message, and handles
	that message correctly according to its specific type.
			
	========
	ANSWER
	========
	
	
`Explicit DISPATCH: ADDING A NEW TYPE`
			
	1.  We should create a new type-specific constructors and selectors.
	2.  We must avoid naming conflict with the rest of the systerm when we name the new type-specifc constructors and selectors.
	3.  The constructors must "tag" the newly constructored data with the approciate type-specific tag.
	4. Each of the generic selectors must be modifoed and updated to recongnize the new type and dispatch accordingly when invoked.
			

`DATA-DIRECTED STYLE: ADDING A NEW TYPE`
			
	1. We must create new type-specific constructors and selectors
	2. Names for these new type-specific constructors and selectors must be chosen in an internally consistent and coherent way, but we need not concern 
	   ourselves with potential naming conflicts arising from outside the new module we are designing.
	3. The constructors must "tag" the newly constructed data with the appropriate type-specific tag.
	4. We must install the newly created type-specific constructors abd selectors into the operations table, under the correct "operation"
	   and "type" selectors.
	   
				
`MESSAGE-PASSING STYLE: ADDING A NEW TYPE`
			
	1. We must define a new type-specific constructor for the type.
	2. The constructor must internally define and implement procedures for handing any possible invocation made to it by a generic selector(i.e. , define
	   the generic selectors in its own type-specific way.)
	3. The new constructor must be named in a globally unique way, but the names chosen internally for handling the various generic selection operations
	   need not be globally unique.
				 
			
`which organization would  be most appropriate for a system in which new types must be often added?`
			
The most appropriate organization for this would be `Message-passing`, and below is my reason:
			
>>  None of the existing types, or their constructors, need to be modified if we are adding a new type. Instead, all we need to do is define the constructor for the
	new type in a globally unique way, and implement type-specific procedures for responding to the generic selectors.
				  
				  
`which organization would be the most approciate for a system in which new operation must ofen be added?`
			
			
The most approciate for this would be `Data-directerd` style, and below is my reason:
			

>> Message-passing style becomes a bit more cumbersome when we are constantly adding new operations, since the dispatch routine in each pre-exising constructor
must be modified to handle the new operation. It's true that in the data-directed style we similarly have to update the install package for each type to support the new
operation, but this seems like a less cumbersome route to go to than in the case of message-passing style.
				  
				  
##Excercise2.77

>Louis Reasoner tries to evaluate the expression (magnitude z) where z is the object
shown in figure 2.24. To his surprise, instead of the answer 5 he gets an error message from applygeneric,
saying there is no method for the operation magnitude on the types (complex). He shows
this interaction to Alyssa P. Hacker, who says ``The problem is that the complex-number selectors were
never defined for complex numbers, just for polar and rectangular numbers. All you have to do to
make this work is add the following to the complex package:''


```racket

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

```

Describe in detail why this works. As an example, trace through all the procedures called in evaluating the
expression (magnitude z) where z is the object shown in figure 2.24. In particular, how many times
is apply-generic invoked? What procedure is dispatched to in each case?

`Answer:` Before Alyssa added the code. We didn't define the  `(magnitude z)` operation in complex, hence the
error. After we defined the `(magnitude z)`, and as long as called, first dispatch will be the magnitude of complex
and second will be magnitude of the rectangular. So the apply-generic is invoked twice.
