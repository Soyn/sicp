##Exercise3.12

>The following procedure for appending lists was introduced in section 2.2.1:

```racket

(define (append x y)
    (if (null? x)
        y
        (cons (car x) (append (cdr x) y))))
        
```

**Append** forms a new list by successively consing the elements of x onto y. The procedure append! is
similar to append, but it is a mutator rather than a constructor. It appends the lists by splicing them
together, modifying the final pair of x so that its cdr is now y. (It is an error to call append! with an
empty x.)

```racket

(define (append! x y)
    (set-cdr! (last-pair x) y)
    x)
```

Here last-pair is a procedure that returns the last pair in its argument:

```racket

(define (last-pair x)
    (if (null? (cdr x))
    x
    (last-pair (cdr x))))
    
```

Consider the interaction

```racket

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
(a b c d)
(cdr x)
<response>
(define w (append! x y))
w
(a b c d)
(cdr x)
<response>

```

What are the missing <response>? Draw box-and-pointer diagrams to explain your answer.

`Solution: `
> the respnse is **(b)** and **(b c d)**, and following is the box-and-pointer diagram


![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.12a.jpg)

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.12b.jpg)

##Exercise3.13

>Consider the following make-cycle procedure, which uses the last-pair procedure defined in exercise 3.12:

```racket

(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)
    
```

Draw a box-and-pointer diagram that shows the structure **z** created by

```racket

(define z (make-cycle (list 'a 'b 'c)))
```
What happens if we try to compute (last-pair z)?

`Solution: `
>Following is the box-and-pointer diagram

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.13.png)



**And if we compute the  (last-pair 'z') we will drop into infinite loop**

##Exercise3.14

>The following procedure is quite useful, although obscure:

```racket

(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                    (set-cdr! x y)
                    (loop temp x))))
    (loop x '()))
    
``` 

**Loop** uses the ``temporary'' variable **temp** to hold the old value of the **cdr** of **x**, since the **set-cdr!** on the next line destroys the **cdr**. Explain what **mystery** does in general. Suppose **v** is defined by **(define v (list 'a 'b 'c 'd))**. Draw the box-and-pointer diagram that represents the list to
which **v** is bound. Suppose that we now evaluate **(define w (mystery v))**. Draw box-and-pointer
diagrams that show the structures **v** and **w** after evaluating this expression. What would be printed as thevalues of **v** and **w** ?

`Solution: `

This procedure `mystery` will produce the inverse order if  **x**.

Following is the box-and-pointer diagram of **( define v (list 'a 'b 'c 'd))**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.14a.png)

Following is the box-and-pointer diagram of **( define w ( mystery v))**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.14b.png)