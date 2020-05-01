;; Excercise 1.1
;; Below is a sequence of expressions.
;; What is the result printed by the interpreter in response to each expression?
;; Assume that the sequence is to be evaluated in the order in which it is presented.

10
; 10

(+ 5 3 4)
; 12

(- 9 1)
; 8

(/ 6 2)
; 3

(+ (* 2 4) (- 4 6))
; 6

(define a 3)
;a = 3

(define b (+ a 1))
; b = 4

(+ a b (* a b))
; 19

(= a b)
; #f

(if (and (> b a) (< b (a * b)))
    b
    a
)
; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; 16

(+ 2 (if (> b a) b a))
; 6

(*  (cond ((> a b) a)
         ((< a b) b)
         (else - 1))
    (+ a 1))
; 16


;; Excercise 1.2
;; Translate the following expression into prefix form

; 5 + 4 + (2 - (3 - (6 + 4/5)))
; -----------------------------
; 3(6 - 2)(2 - 7)

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7))
)

;; Excercise 1.3
;; Define a procedure that takes three numbers as arguments
;; and returns the sum of the squares of the two larger numbers.

(define (square x) (* x x))

(define (sum_of_squares a b) (+ (square a) (square b)))

(define (sum_of_squares_for_two_larger_numbers a b c)
  (cond ((> a b) (cond ((> b c) (sum_of_squares a b))
                        (else (sum_of_squares a c))))
        (else   (cond ((> a c) (sum_of_squares a b))
                        (else (sum_of_squares c b))))
  )
)

;; Excercise 1.4
;; Observe that our model of evaluation allows for combinations whose operators are compound expressions.
;; Use this observation to describe the behavior of the following procedure:

;; (define (a-plus-abs-b a b)
;;  ((if (> b 0) + -) a b))

;; a-plus-abs-b returns a + b when b > 0 and a - b otherwise

;; Exercise 1.5
;; Ben Bitdiddle has invented a test to determine whether the interpreter
;; he is faced with is using applicative-order evaluation or normal-order evaluation.
;; He defines the following two procedures:

;; (define (p) (p))

;; (define (test x y)
;;   (if (= x 0)
;;       0
;;       y))

;; Then he evaluates the expression

;; (test 0 (p))

;; What behavior will Ben observe with an interpreter that uses applicative-order evaluation?
;; What behavior will he observe with an interpreter that uses normal-order evaluation?
;; Explain your answer. (Assume that the evaluation rule for the special form if is the same
;; whether the interpreter is using normal or applicative order:
;; The predicate expression is evaluated first, and the result determines whether to evaluate
;; the consequent or the alternative expression.)

; when application-order evaluation is used, expression will return zero
; when normal-order evaluation is used, expression will never terminate, since
; (p) always resolves to itself.
