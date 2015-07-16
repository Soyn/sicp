#lang racket
#|
                Ex2.68  
                @Soyn
                @Brief: the encode procedure takes as arguments a message and a tree 
                   and produces the list of bits that gives the encoded message.And encode-symbol
                  is a procedure,which you must write,that returns the list of bits that encodes a given
                  symbol according to a given tree.You should design encode-symbol so that it signals an
                  error if the symbol is not in the tree .Test your procedure by encoding the result you obtained
                  in exercise2.67 with the sample tree and seeing whether it is the same as the original sample message.
|#

;---------------------------This is encode-process---------------------------------- 
( define( make-leaf symbol weight)
   ( list 'leaf symbol weight))

( define ( leaf? object)
   ( eq? ( car object) 'leaf))

( define ( symbol-leaf x) ( cadr x)) ;get the symbols in list     

( define ( weight-leaf x) ( caddr x))     ;get the weight 

( define ( make-code-tree left right)
   ( list left
         right
         ( append ( symbols left) ( symbols right))
         (+ ( weight left) ( weight right))))

( define ( left-branch tree) ( car tree))

( define ( right-branch tree) ( cadr tree))

( define ( symbols tree)
   ( if ( leaf? tree)
       ( list ( symbol-leaf tree))
       ( caddr tree)))

( define ( weight tree)
   ( if ( leaf? tree)
       ( weight-leaf tree)
       ( cadddr tree)))
;--------------------------------------------------------------------------------------------------

( define ( encode message tree)
   ( if ( null? message)
       null
       ( append ( encode-symbol ( car message) tree)
               ( encode ( cdr message) tree))))

( define ( element-of-set? x set)
   ( cond ( ( null? set) false)
         ( ( equal? x ( car set)) true)
         ( else ( element-of-set? x ( cdr set)))))


( define ( encode-symbol msg tree)
   (define ( branch-correct? branch)
     ( if ( leaf? branch)
         ( equal? msg ( symbol-leaf branch))
         ( element-of-set? msg ( symbols branch))))
   ( let ( ( lb ( left-branch tree))
           ( rb ( right-branch tree)))
      ( cond ( ( branch-correct? lb)
               ( if ( leaf? lb) '(0) ( cons 0 ( encode-symbol msg lb))))   ;if the leaf is '0',entry the left-branch
            ( ( branch-correct? rb)
              ( if ( leaf? rb) '(1) ( cons 1 ( encode-symbol msg rb))))
            ( else ( error "bad symbol---ENCODE--SYMBOL" 'bit)))))  ; handle exception


;test

( define sample-tree
   ( make-code-tree ( make-leaf 'A 4)
                   ( make-code-tree
                     ( make-leaf 'B 2)
                     ( make-code-tree ( make-leaf 'D 1)
                                     ( make-leaf 'C 1)))))

( encode '(A D A B B C A) sample-tree)
