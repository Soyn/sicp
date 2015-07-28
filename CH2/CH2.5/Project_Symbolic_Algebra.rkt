#lang racket

;; Project: Symbolic Algebra
;; Created by Soyn. 27/7/15

( define ( install-polynomial-package)
   ;; internal procedure
   ;; representation of poly
   ( define ( make-poly variable term-list)
      ( cons variable term-list))
   ( define ( variable p) ( car p))
   ( define ( term-list p) ( cdr p))
   ( define ( variable? x) ( symbol? x))
   ( define ( same-variable? v1 v2)
      ( and ( variable? v1) ( variable? v2) ( eq? v1 v2)))
   ( define ( add-poly p1 p2)
      ( if ( same-variable? ( variable p1) ( variable p2))
          ( make-poly ( variable p1)
                     ( add-terms ( term-list p1)
                                ( term-list p2)))
          ( error "Polys not in same var ---ADD-POLY"
                 ( list p1 p2))))
   ( define ( mul-poly p1 p2)
      ( if ( same-variable? ( variable p1) ( variable p2))
          ( make-poly ( variable p1)
                     ( mul-terms ( term-list p1)
                                ( term-list p2)))
          ( error " Polys not in same var -- MUL-POLY"
                 ( list p1 p2))))
   ;; interface to rest of systerm
    ( define ( tag p) ( attach-tag 'polynomial p))
   ( put 'add '( polynomial polynomial)
        ( lambda ( p1 p2) ( tag ( add-poly p1 p2))))
   ( put 'mul '( polynomial polynomial)
        ( lambda ( p1 p2) ( tag ( mul-poly p1 p2))))
   ( put 'make 'polynomial 
        ( lambda ( var terms) ( tag ( make-poly var terms))))
   'done)


( define ( add-terms L1 L2)
   ( cond ( ( empty-termlist? L1) L2)
            ( ( empty-termlist? L2) L1)
            ( else
              ( let( ( t1 ( first-term L1)) ( t2 ( first-term L2)))  ;; `first-term` is a selector that extracts the highest-order term from a term list
                 ( cond ( ( > ( order t1) ( order t2))
                          ( adjoin-term                ;; `adjoin-term` is a constructor that adjoins a new term to a term list.
                            t1( add-terms ( rest-terms L1) L2)))     ;; `rest-terms` is a selector that returns all but the highest-order term.
                       ( ( < ( order t1) ( order t2))         ;; `order` returns the order of the term
                         ( adjoin-term
                           t2 ( add-terms L1 ( rest-terms L2))))
                       ( else
                         ( adjoin-term
                           ( make-term ( order t1)   ;;if equals, `make-term` will be invoked, we add the coefficient and construct a new term, then adjoin it to rest of term list.
                                      ( add ( coeff t1) ( coeff t2)))    ;; the `coeff` returns the coefficient of the term.
                           ( add-terms ( rest-terms L1)
                                      ( rest-terms L2)))))))))

( define ( mul-terms L1 L2)
   ( if ( empty-termlist? L1)
       ( the-empty-termlist)
       ( add-terms ( mul-term-by-all-terms ( first-term L1) L2)   ;; select a highest order term to mul
                  ( mul-terms ( rest-terms L1) L2))))

( define ( mul-term-by-all-terms t1 L)
   ( if ( empty-termlist? L1)
       ( the-empty-termlist)
       ( let ( ( t2 ( first-term L)))
          ( adjoin-term
            ( make-term ( + ( order t1) ( order t2))     ;; add the order of term
                       ( mul ( coeff t1) ( coeff t2)))           ;; mul the coefficient
            ( mul-term-by-all-terms t1 ( rest-terms L))))))


