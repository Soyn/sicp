#lang racket

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



( define rocktree ( generate-huffman-tree'( (a 2) ( na 16) (boom 1) (Sha 3) ( Get 2) (yip 9) (job 2) ( Wah 1))))

( display rocktree)
( define rock-song '( Get a job Sha na na na na na na na na Get a job Sha na na na na na na na na
                           Wah yip yip yip yip yip yip yip yip yip Sha boom))

( define encoded-rock-song ( encode rock-song rocktree))

( display encoded-rock-song)

( length encoded-rock-song)

(* 3( length rock-song))
