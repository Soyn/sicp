##[Exercise3.01](Ex3.01.rkt)

##[Exercise3.02](Ex3.02.rkt)

##[Exercise3.03](Ex3.03.rkt)

##[Exercise3.04](Ex3.04.rkt)

##[Exercise3.05](Ex3.05.rkt)

##[Exercise3.06](Ex3.06.rkt)

##[Exercise3.07](Ex3.07.rkt)

##[Exercise3.08](Ex3.08.rkt)

##Exercise3.09

> In section 1.2.1 we used the substitution model to analyze two procedures for computing
   factorials, a recursive version
   
 ```racket

        (define (factorial n)
            (if (= n 1)
                1
                (* n (factorial (- n 1)))))

``` 

and an iterative version

```racket

    (define (factorial n)
        (fact-iter 1 1 n))
    (define (fact-iter product counter max-count)
        (if (> counter max-count)
            product
            (fact-iter (* counter product)
                            (+ counter 1)
                            max-count)))
```
Show the environment structures created by evaluating (factorial 6) using each version of the
factorial procedure.

`Solution: `

**Following is the procedure of creating recurison factorial.**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.09a.jpg)

**Following is the envirment structure created by evaluating (factorial 6)** 

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.09b.jpg)

**Following is the envirment structure created by (factorial n)**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.09c.jpg)

**Following is the envirment structure created by evaluating ( factorial 6)**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.09d.jpg)

##Exercise3.10

> In the make-withdraw procedure, the local variable balance is created as a
   parameter of make-withdraw. We could also create the local state variable explicitly, using let, as
   follows:
   
   

```racket

    (define (make-withdraw initial-amount)
        (let ((balance initial-amount))
            (lambda (amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                    balance)
                    "Insufficient funds"))))
                
```

Recall from section 1.3.2 that let is simply syntactic sugar for a procedure call:

```racket

        (let ((<var> <exp>)) <body>)

```

is interpreted as an alternate syntax for

```racket

((lambda (<var>) <body>) <exp>)


```

Use the environment model to analyze this alternate version of make-withdraw, drawing figures like
the ones above to illustrate the interactions

```racket

    (define W1 (make-withdraw 100))
    (W1 50)
    (define W2 (make-withdraw 100))
    
```
>Show that the two versions of make-withdraw create objects with the same behavior. How do the
senvironment structures differ for the two versions?

`Solution: `

**Following is the envirment structure created by `make-withdraw`**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.10a.jpg)

**Following is the envirment structure created by '(define w1 ( make-withdraw 100)) , ( w1 50) and ( define ( w2 ( make-withdraw 100)))'**

![image](https://github.com/Soyn/sicp/blob/master/screenshots/Ex3.10b.jpg)

