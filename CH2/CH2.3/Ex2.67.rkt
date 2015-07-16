#lang racket

;Ex2.67
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

;-----------This is decode-process--------------------------------------------------------
;the parament in decode-1: bits: the list was made of by 0/1
;                         tree: the current-tree's position
;we move to the leaf from the root,and when we reach the leaf,then construct the symbol in leaf node with the rest code.
( define ( decode bits tree)     
   ( define ( decode-1 bits current-branch)
      ( if( null? bits)
          null
          ( let ( ( next-branch
                    ( choose-branch ( car bits) current-branch)))
             ( if ( leaf? next-branch)    ; if reach the leaf,then cons symbol with the next branch
                 ( cons ( symbol-leaf next-branch)
                       ( decode-1 ( cdr bits) tree))
                 ( decode-1 ( cdr bits) next-branch)))))
   ( decode-1 bits tree))

( define ( choose-branch bit branch)
   ( cond ( ( = bit 0) ( left-branch branch))
         ( ( = bit 1) ( right-branch branch))
         ( else ( error "bad bit --CHOOSE-BRANCH" bit))))        ;if the bit is not 0/1,then throw error
;---------------------------------------------------------------------------------------------------------------

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

;----------------------------------------------------------------------------------------------------------------



;Ex2.67
;@breif: Define an encoding tree and a sample message

( define  sample-tree ;define a encoding tree.
           ( make-code-tree( make-leaf 'A 4)
                           ( make-code-tree
                             ( make-leaf 'B 2)
                             ( make-code-tree ( make-leaf 'D 1)
                                             ( make-leaf 'C 1)))))

( define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;decoding the tree
( decode sample-message sample-tree)