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
>> ```racket

        (define (factorial n)
            (if (= n 1)
                1
                (* n (factorial (- n 1)))))

``` 

>and an iterative version
>> ```racket
    (define (factorial n)
        (fact-iter 1 1 n))
    (define (fact-iter product counter max-count)
        (if (> counter max-count)
            product
            (fact-iter (* counter product)
                            (+ counter 1)
                            max-count)))
```

`Solution: `

**Following is the procedure of creating recurison factorial.**
![image]()

