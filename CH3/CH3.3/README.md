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


##Exercise3.15 
> Draw box-and-pointer diagrams to explain the effect of set-to-wow! on the structures z1 and z2 above.

`Solution: `

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.15a.png)

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.15b.png)


##Exercise3.16

>Ben Bitdiddle decides to write a procedure to count the number of pairs in any list structure. 
   "It's easy,'' he reasons. The number of pairs in any structure is the number in the car plus the
    number in the cdr plus one more to count the current pair.'' So Ben writes the following procedure:
    
```racket

    (define (count-pairs x)
        (if (not (pair? x))
            0
            (+ (count-pairs (car x))
                (count-pairs (cdr x))
                1)))
```

Show that this procedure is not correct. In particular, draw box-and-pointer diagrams representing list
structures made up of exactly three pairs for which Ben's procedure would return 3; return 4; return 7;
never return at all.

`Solution: `

- The procedure returns 3 is `( define three (cons (cons 'a '()) ( cons 'b ())))`, following is the box-and-pointer diagram.

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.16_3.png)

- The procedure returns 4 is '( define four (cons 'a ( cons 'b '())))', following is the box-and-pointer diagram.

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.16_4.png)

- The procedure returns 7 is `( define seven (cons three three))`,following is the box-and-pointer diagram.

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.16_7.png)

- The procedure has no return-value is '( define crycle (cons a(cons a '())))' and then `( set-cdr! ( last-pair crycle) crycle)`, following is the box-and-pointer diagram.

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.16_crycle.png)

##[Exercise3.17](Ex3.17.rkt)

##[Exercise3.18](Ex3.18.rkt)

##[Exercise3.19](Ex3.19.rkt)

##Exercise3.20

>Draw environment diagrams to illustrate the evaluation of the sequence of expressions

```racket

    (define x (cons 1 2))
    (define z (cons x x))
    (set-car! (cdr z) 17)
    (car x)
    17

```

using the procedural implementation of pairs given above. (Compare exercise 3.11.)


`Solution: `

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.20_1.png)

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.20_2.png)

##Exercise3.21
>Exercise 3.21. Ben Bitdiddle decides to test the queue implementation described above. He types in the
procedures to the Lisp interpreter and proceeds to try them out:

```racket

    (define q1 (make-queue))
    (insert-queue! q1 'a)
    ((a) a)
    (insert-queue! q1 'b)
    ((a b) b)
    (delete-queue! q1)
    ((b) b)
    (delete-queue! q1)
    (() b)

```

``It's all wrong!'' he complains. ``The interpreter's response shows that the last item is inserted into the
queue twice. And when I delete both items, the second b is still there, so the queue isn't empty, even
though it's supposed to be.'' Eva Lu Ator suggests that Ben has misunderstood what is happening. ``It's not
that the items are going into the queue twice,'' she explains. ``It's just that the standard Lisp printer doesn't
know how to make sense of the queue representation. If you want to see the queue printed correctly, you'll
have to define your own print procedure for queues.'' Explain what Eva Lu is talking about. In particular,
show why Ben's examples produce the printed results that they do. Define a procedure print-queue
that takes a queue as input and prints the sequence of items in the queue.

`Solution: `

The interpreter print the `car`'s part and 'cdr''s part of queue. So we get the result like Ben. And we can design the `print-queue`
which returns the `car`'a part of the queue.

```racket
    (define (print-queue queue) ( car queue))
```

##[Exercise3.22](Ex3.22.rkt)

##[Exercise3.25](Ex3.25.rkt)
