#lang racket
;--------Support Function-------------------
(define ( make-tree entry left right)
  ( list entry left right))

( define ( entry tree) ( car tree))

( define ( left-branch tree) ( cadr tree))

( define ( right-branch tree) ( caddr tree))

( define ( tree->list-1 tree)
   ( if ( null? tree)null
       (append ( tree->list-1 ( left-branch tree))
       ( cons ( entry tree)
             ( tree->list-1 ( right-branch tree))))))

(define ( adjoin-set x set)
  ( cond ( (null? set) ( make-tree x null null))
        ( ( = x ( entry set)) set)
        ( ( < x ( entry set))
          ( make-tree ( entry set)
                     ( adjoin-set x (left-branch set))
                     ( right-branch set)))
        ( ( > x ( entry set))
          ( make-tree ( entry set)
                     ( left-branch set)
                     ( adjoin-set x ( right-branch set))))))

;------------------------------------------------------------------
;   !Ex2.63
;   @Soyn
( define ( tree->list-2 tree)
   ( define ( copy-to-list tree result-list)
      ( if(null? tree)
          result-list
          ( copy-to-list ( left-branch tree)
                        ( cons ( entry tree)
                              ( copy-to-list ( right-branch tree)
                                            result-list)))))
   ( copy-to-list tree null))

;--------Usage Test--------------

( define t (make-tree 2 null null))

( define t1 ( adjoin-set 5 t))

( define t2 ( adjoin-set 3 t1))

( define t3 ( adjoin-set 1 t2))

t3

(tree->list-1 t3)

( tree->list-2 t3)

;both procedures produce the same result

;!!!for tree->list-1
;!!!! T(n) = 2*T(n/2) + O(n) =====> T(n) = O(n*lg n) (as the append takes linear time)


;;;;; for the tree->list-2
;;;;;;; T(n) = 2*T(n/2) + O(1) =======> T(n) = O(n)

; so the second function is more quick.

