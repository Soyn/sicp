##[Excecise2.70](Ex2.70.rkt)
>The following eight-symbol alphabet with associated relative frequencies was designed to
efficiently encode the lyrics of 1950s rock songs. (Note that the ``symbols'' of an ``alphabet'' need not be
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
