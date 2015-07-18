#lang racket

#|
    Ex2.69
   @Soyn
   @Brief: the following procedure takes as its argument a list  of symbol-frequency pairs(
    where no symbol appears in more than one pair) and generates a Huffman encoding tree
    according to the Huffman algorithm.

    ( define ( generate-huffman-tree pairs)
       ( successive-merge ( make-leaf-set pairs)))

   make-leaf-set is the procedure given above that transforms the list of pairs into an ordered
  set of leaves.successive-merge is the procedure you must write, using make-code-tree to successively
  merge the smallest-weight elements of the set unyil there is only one element left,which is the desired
  Huffman tree.(This procedure is slightly tricky,but not really comp;licated. If you find yourself desinging
  a complex procedure, then you are almost certainly doing something wrong.You can take significant
  advantage of the fact that we are using an ordered set representation.)
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

;----------------------------This is help function--------------------------------------------------------------
( define ( adjoin-set x set)   ;order the elements by weight
   ( cond ( ( null? set) ( list x))
         ( ( < ( weight x) ( weight ( car set))) ( cons x set))
         ( else ( cons ( car set)
                      ( adjoin-set x ( cdr set))))))

( define( make-leaf-set pairs)   ;initialize the set
   ( if ( null? pairs)
       null
       ( let ( ( pair ( car pairs)))
          ( adjoin-set ( make-leaf( car pair)
                                  ( cadr pair))
                      ( make-leaf-set ( cdr pairs))))))

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


;----------------------------------------------------------------------------------------------------------------


( define ( generate-huffman-tree pairs)
   ( successive-merge ( make-leaf-set pairs)))

( define ( successive-merge leaf-set)
   ( if ( = ( length leaf-set) 1)
       ( car leaf-set)
       ( let ( ( first ( car leaf-set))    
               ( second ( cadr leaf-set))
               ( rest ( cddr leaf-set)))
          ( successive-merge ( adjoin-set ( make-code-tree first second)
                                         rest)))))

;test
( define sample-tree
   ( make-code-tree ( make-leaf 'A 4)
                   ( make-code-tree
                     ( make-leaf 'B 2)
                     ( make-code-tree ( make-leaf 'D 1)
                                     ( make-leaf 'C 1)))))

( define test-tree(generate-huffman-tree '( ( A 3) ( B 5) ( C 6) ( D 6))))

( encode '( A B C D) test-tree)
