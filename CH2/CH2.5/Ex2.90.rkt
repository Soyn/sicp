#lang racket

;; Ex2.90
;; Created by Soyn. 30/7/15.
;; @Brief:Suppose we want to have a polynomial system that is efficient for both sparse and dense
;; polynomials. One way to do this is to allow both kinds of term-list representations in our system. The
;; situation is analogous to the complex-number example of section 2.4, where we allowed both rectangular
;; and polar representations. To do this we must distinguish different types of term lists and make the
;; operations on term lists generic. Redesign the polynomial system to implement this generalization. This is
;; a major effort, not a local change.

( define ( the-empty-termlist term-list)
   ( let ( ( proc ( get 'the-empty-termlist ( type-tag term-list))))
      ( if proc
          ( proc)
          ( error "No proc found-- THE-EMPTY-TERMLIST" term-list))))

( define ( rest-terms term-list)
   ( let ( ( proc ( get 'rest-terms ( type-tag term-list))))
      ( if proc
          ( proc term-list)
          ( error "--REST-TERMS" term-list))))

( define ( empty-termlist? term-list)
   ( let ( ( proc ( get 'empty-termlist? ( type-tag term-list))))
      ( if proc
          ( proc term-list)
          ( error "--EMPTY-TERMLIST?" term-list))))

( define ( make-term order coeff) ( list order coeff))

( define ( order term)
   ( if ( pair? term)
       ( car term)
       ( error "Term not pair--ORDER" term)))

( define ( coeff term)
   ( if ( pair? term)
       ( cadr term)
       ( error "Term not pair --COEFF" term)))

;; define the constructor and selector

( define ( first-term term-list)
   ( let ( ( proc ( get 'first-term ( type-tag term-list))))
      ( if proc
          ( proc term-list)
          ( error "No first-term for this list --FIRST-TERM" term-list))))

( define ( install-polynomial-term-package)
   ( define ( first-term-dense term-list)
      ( if ( empty-termlist? term-list)
          null
          ( list
            ( - ( length ( cdr term-list)) 1)
            ( car  ( cdr term-list)))))
   ( define ( first-term-sparse term-list)
      ( if ( empty-termlist? term-list)
          null
          ( cadr term-list)))
   ( define ( prep-term-dense term term)
      ( if ( null? term)
          null
          ( cdr term)))
   ( define ( prep-term-sparse term)
      ( if ( null? term)
          null
          ( list term)))
   ( define ( the-empty-term-list-dense) '( dense))
   ( define ( the-empty-term-list-saprse) '( sparse))
   ( define ( rest-terms term-list) ( cons ( type-tag term-list) ( cddr term-list)))
   ( define ( empty-termlist?  term-list)
      ( if ( pair? term-list)
          ( >= 1 ( length term-list))
          ( error "Term-list not pair --EMPTY-TERMLIST?" term-list)))
   ( define ( make-polynomial-dense var terms)
      ( make-polynomial var ( cons 'dense ( map cadr terms))))
   ( define ( make-polynomial-sparse var terms)
      ( make-polynomial var ( cons 'sparse terms)))
   ( put 'first-term 'sparse
        ( lambda ( term-list) ( first-term-sparse term-list)))
   ( put 'first-term 'dense
        ( lambda ( term-list) ( first-term-dense term-list)))
   ( put 'prep-term 'dense
        ( lambda ( term) ( prep-term-dense term)))
   ( put 'perp-term 'sparse
        ( lambda ( term) ( prep-term-sparse term)))
   ( put 'rest-terms 'dense
        ( lambda ( term-list) ( rest-terms term-list)))
   ( put 'rest-terms 'sparse
        ( lambda ( term-list) ( rest-term-list term-ist)))
   ( put 'empty-termlist 'dense
        ( lambda ( term-list) ( empty-termlist? term-list)))
   ( put 'empty-termlist? 'sparse
        ( lambda ( term-list) ( empty-termlist? term-list)))
   ( put 'the-empty-termlist 'dense
        (lambda () ( the-empty-termlist-dense)))
   ( put 'the-empty-termlist 'sparse
        ( lambda () ( the-empty-termlist-sparse)))
   ( put 'make-polynomial 'sparse
        ( lambda (var terms) ( make-polynomial-sparse var terms)))
   ( put 'make-polynomial 'dense
        ( lambda ( var terms) ( make-polynomial-dense var terms)))
   'done)

( install-polynomial-term-package)

( define ( zero-pad x type)
   ( if ( eq? type 'sparse)
       null
       ( if ( = x 0)
           null
           ( cons 0 (add-zeros ( -x 1))))))

( define ( adjoin-term term term-list)
   ( let ( ( preped-term ( ( get 'prep-term ( type-tag term-list)) term))
           ( preped-term ( ( 'get 'prep-term ( type-tag term-list))
                           ( first-term term-list))))
      ( cond ( ( =zero? ( coeff term)) term-list)
            ( ( empty-termlist? term-list) ( append ( the-empty-termlist term-list)
                                                   preped-term
                                                   ( zero-pad ( order term)
                                                             ( type-tag
                                                               term-list))))
            ( ( > ( order term) ( order ( first-term term-list)))
              ( append ( list ( car term-list))
                      preped-term
                      ( zero-pad ( - ( - ( order term)
                                        ( order ( first-term term-list)))
                                    1) ( type-tag term-list))
                      ( cdr term-list)))
            ( else
              ( append preped-first-term
                      ( adjoin-term term ( rest-terms term-list)))))))

( define ( negate p)
   ( let ( ( neg-p ( ( get 'make-polynomial ( type-tag ( term-list p)))
                     ( variable p) ( list ( make-term 0 -1)))))
      ( mul-poly ( cdr neg-p) p)))
