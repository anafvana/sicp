#lang sicp

; Programming basics, as set by John Locke, paraphrased by me
; Compose	->	Put functions together
; Compare	->	Flow control
; Abstract	->	Layers of abstraction


; Different arithmetic order because still function -> CONSISTENCY
(+ 2 2) ; 4
(- 4 2) ; 2
(* 2 2) ; 4
(/ 4 2) ; 2

; Also possible with multiple arguments for + and *
(+ 2 2 2 2 2) ; 10
(* 2 2 2 2 2) ; 32

; Nesting
(+ (* 2 4) (- 5 2)) ; 11

; Define is used to define values (= in other languages) -> take name and value, and bind
(define size 2)
size ; 2
(+ 0 size) ; 2

(define pi 3.14159)
(define radius 10)
(define circumference (* 2 pi radius)) ; 62.8318

; How combinations are evaluated
(* (+ 2 (* 4 6)) (+ 3 5 7)) ; 390
; 390
; ├─ *
; ├─ 26
; │   ├─ +
; │   ├─ 2
; │   └─ 24
; │  	  ├─ *
; │  	  ├─ 4
; │		  └─ 6
; └─ 15
; 	 ├─ +
; 	 ├─ 3
; 	 ├─ 5
; 	 └─ 7

; Functions = Compound expressions/procedures
(define (square x) (* x x))
(square 8) ; 64

; It's obviously possible to reuse your own definitions
(define (sum-of-squares x y) (+ (square x) (square y)))
(sum-of-squares 5 8) ; 89


; Conditionals (cond)
(define (absolute x)
  (cond ((> x 0) x)
		((= x 0) 0)
		((< x 0) (- x))))
(absolute (- 4)) ; 4

(define (absolute2 x)
  (cond ((>= x 0) x)
		(else (- x))))
(absolute2 (- 4)) ; 4

; Conditionals (if)
(define (absolute3 x)
  (if (< x 0)	; if condition
  	 (- x)		; then
	 x))		; else
(absolute3 (- 5)) ; 5

; Boolean operators
(define x 7)
(and (> x 5) (< x 10)) ; #t
(or (< x 5) (> x 10)) ; #f
(not (= x 7)) ; #f

; EXERCISES
; 1.3
(define (numberize bool) (if bool 0 1))

(define (sumdevil x y z)
  (+ (* (square x) (numberize (and (< x y) (< x z))))
	 (* (square y) (numberize (and (< y x) (< y z))))
	 (* (square z) (numberize (and (< z x) (< x y)))))) ; ; Empty result.
(sumdevil 1 2 3)  ; 13

(define (larger a b) (if (> a b) a b))

(define (smaller a b) (if (< a b) a b))

(define (sumelegant x y z)
  (sum-of-squares
	(larger x y)
	(larger z (smaller x y))))
(sumdevil 1 2 3)  ; 13

; Function calls can be results of functions
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Applicative or normal order
; There are two orders for evaluating expressions: applicative and normal
; Normal: expand first and then simplify
; Applicative: try to simplify and expand as needed
; Generally, you wanna go for applicative.
; Each interpreter makes a choice of which one it does, though

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))
; An applicative compiler will return 0
; A normal compiler will go into an infinite loop
