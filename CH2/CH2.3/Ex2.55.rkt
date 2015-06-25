#lang racket

;Ex 2.55

; (car ' 'abracadabra)被解释为( car ( quote ( quote abracadabra)))
; 第一个quote引用了(quote abracadabra)
;( quote abracadabra)是一个含有两个元素的list，因此caring它输出的是quote

( car ' 'abracadabra)