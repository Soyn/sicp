##[Excecise2.53](Ex2.53.rkt)
##[Excecise2.54](Ex2.54.rkt)
##[Excecise2.55](Ex2.55.rkt)
##[Excecise2.56](Ex2.56.rkt)
##[Excecise2.57](Ex2.57.rkt)
##Excecise2.58
##[Excecise2.59](Ex2.59.rkt)
##[Excecise2.60](Ex2.60.rkt)
##[Excecise2.61](Ex2.61.rkt)
##[Excecise2.62](Ex2.62.rkt)
##[Excecise2.63](Ex2.63.rkt)
##[Excecise2.64](Ex2.64.rkt)
##[Excecise2.65](Ex2.65.rkt)
##[Excecise2.66](Ex2.66.rkt)
##[Excecise2.67](Ex2.67.rkt)
##[Excecise2.68](Ex2.68.rkt)
##[Excecise2.69](Ex2.69.rkt)
##[Excecise2.70](Ex2.70.rkt)
>The following eight-symbol alphabet with associated relative frequencies was designed to
efficiently encode the lyrics of 1950s rock songs. (Note that the `symbols` of an `alphabet`need not to be
individual letters.)


A 2 NA 16<br>
BOOM 1 SHA 3<br>
GET 2 YIP 9<br>
JOB 2 WAH 1<br>

>Use generate-huffman-tree (exercise 2.69) to generate a corresponding Huffman tree, and use
encode (exercise 2.68) to encode the following message:


Get a job<br>
Sha na na na na na na na na<br>
Get a job<br>
Sha na na na na na na na na<br>
Wah yip yip yip yip yip yip yip yip yip<br>
Sha boom<br>


>How many bits are required for the encoding? What is the smallest number of bits that would be needed to
encode this song if we used a fixed-length code for the eight-symbol alphabet?

###This is the rocktree


![image](https://github.com/Soyn/sicp/blob/master/screenshots/rocktree.png)

###This is the encoded-rock-song

![image](https://github.com/Soyn/sicp/blob/master/screenshots/encoded-rock-song.png)

- And we can get the length by using the `(length encoded-rock-tree)`,and we get 84. If we were to use a fixed-length encoding on that rock song, we would need 3 bits (8 = 2^3) per symbol. So we can do this to figure how many bits we need to use:

  ```racket
  (* 3 ( length rock-song))
  ```
  
  and we get 108.
  

##Excecise2.71

>Exercise 2.71. Suppose we have a Huffman tree for an alphabet of n symbols, and that the relative
frequencies of the symbols are 1, 2, 4, ..., 2^n-1. Sketch the tree for n=5; for n=10. In such a tree (for
general n) how may bits are required to encode the most frequent symbol and the least frequent symbol?

>>And we use the alphabet to represent the symbols
so we can get this Huffman Tree

                   {a b c d e} 31
                     /           \
                {a b c d} 15      e 16
                 /     \
           {a b c} 7    d 8
             /    \
        {a b} 3    c 4
         /   \
      a 1    b 2



The tree for n = 10 looks simliar,only larger.the minimum number of bits to constructa symbol(i.e. shortest way to the leaf) for such tree the is 1, for the symbol of weight `2^n-1`.

the maximum number of bits will be `n-1`, for the two symbols of least weights. 

##Exercise2.72

>`Consider the encoding procedure that you designed in [exercise 2.68](Ex2.68). What is the order of
growth in the number of steps needed to encode a symbol? Be sure to include the number of steps needed
to search the symbol list at each node encountered. To answer this question in general is difficult. Consider
the special case where the relative frequencies of the n symbols are as described in exercise 2.71, and give
the order of growth (as a function of n) of the number of steps needed to encode the most frequent and least
frequent symbols in the alphabet.`

>>For the special case in Exercise2.71, the order of growth encoding the most frequent symbol is O(1). As for the least frequent symbol, the order of growth is O(n^2). The most expensive part of
the operation is to search the symbol list at each node. The number of steps required for searching an unordered list of m elements is O(m). For the least frequent symbol, we need to go down the tree
O(n) times and search at every node encountered. Thus the order of growth of the number of steps is `1 + 2 + 3 + ... +n` => O(n^2).
