; Exercise 1.1
; Below is a sequence of expressions.
; What is the result printed by the interpreter in response to each expression?
; Assume that the sequence is to be evaluated in the order in which it is presented.
;
; Answer:

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


; Exercise 1.2
; Translate the following expression into prefix form
;
; Answer:
; 5 + 4 + (2 - (3 - (6 + 4/5)))
; -----------------------------
; 3(6 - 2)(2 - 7)

; Answer
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7))
)


; Exercise 1.3
; Define a procedure that takes three numbers as arguments
; and returns the sum of the squares of the two larger numbers.
;
; Answer
(define (square x) (* x x))

(define (sum_of_squares a b) (+ (square a) (square b)))

(define (sum_of_squares_for_two_larger_numbers a b c)
  (cond ((> a b) (cond ((> b c) (sum_of_squares a b))
                        (else (sum_of_squares a c))))
        (else   (cond ((> a c) (sum_of_squares a b))
                        (else (sum_of_squares c b))))
  )
)


; Exercise 1.4
; Observe that our model of evaluation allows for combinations whose operators are compound expressions.
; Use this observation to describe the behavior of the following procedure:
;
; (define (a-plus-abs-b a b)
;  ((if (> b 0) + -) a b))
;
; Answer:
; a-plus-abs-b returns a + b when b > 0 and a - b otherwise


; Exercise 1.5
; Ben Bitdiddle has invented a test to determine whether the interpreter
; he is faced with is using applicative-order evaluation or normal-order evaluation.
; He defines the following two procedures:
;
; (define (p) (p))
;
; (define (test x y)
;   (if (= x 0)
;       0
;       y))
;
; Then he evaluates the expression
;
; (test 0 (p))
;
; What behavior will Ben observe with an interpreter that uses applicative-order evaluation?
; What behavior will he observe with an interpreter that uses normal-order evaluation?
; Explain your answer. (Assume that the evaluation rule for the special form if is the same
; whether the interpreter is using normal or applicative order:
; The predicate expression is evaluated first, and the result determines whether to evaluate
; the consequent or the alternative expression.)
;
; Answer:
; when application-order evaluation is used, expression will return zero
; when normal-order evaluation is used, expression will never terminate, since
; (p) always resolves to itself.


; Exercise 1.6
; see https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_thm_1.6
;
; Answer
; When 'if' special form is used, only expression which satisfies the predicate is evaluated.
; That is not true for 'new-if' procedure.
; In 'sqrt-iter', implemented with 'new-if', stack overflow will occur since 'sqrt-iter' will
; always recursively call itself regardless of predicate result.


; Exercise 1.7
; TODO


; Exercise 1.8
; TODO


; Exercise 1.9
; see https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.9
; (define (+ a b)
;   (if (= a 0)
;       b
;       (inc (+ (dec a) b))))
;
; (define (+ a b)
;   (if (= a 0)
;       b
;       (+ (dec a) (inc b))))
;
; Answer
; first process is recursive, since '+' procedure needs to wait
; for the result of itself to finish calculation.
; second one is iterative, since all data needed for evaluation is available
; from the scope of the procedure (and from the global scope - procedures 'dec' and 'inc')


; Exercise 1.10
; see https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.10
; (define (A x y)
;   (cond ((= y 0) 0)
;         ((= x 0) (* 2 y))
;         ((= y 1) 2)
;         (else (A (- x 1)
;                  (A x (- y 1))))))
;
; What are the values of the following expressions?
; (A 1 10)
;
; (A 2 4)
;
; (A 3 3)
;
; Answer:
; (A 1 10) - 2^10 = 1024
; (A 2 4) - ... (A 1 16) = 2^16 = 65536
; (A 3 3) - ... (A 1 16) = 2^16 = 65536
;
; Consider the following procedures, where A is the procedure defined above:
;
; (define (f n) (A 0 n))
;
; (define (g n) (A 1 n))
;
; (define (h n) (A 2 n))
;
; (define (k n) (* 5 n n))
; 
; Give concise mathematical definitions for the functions computed by the procedures f, g, and h 
; for positive integer values of n. For example, (k n) computes 5n2.
;
; Answer:
;
; (define (f n) (A 0 n)) - evaluates (2 * n)
; (define (g n) (A 1 n)) - evaluates 0 for n = 0, 2^n for n > 1
; (define (h n) (A 2 n)) - evaluates 0 for n = 0, 2 for n = 1, 2^(2^n) for n > 1


; Exercise 1.11
; see https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_thm_1.11
;
; Answer:
; Recursive process

(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1)) 
                 (f (- n 2)) 
                 (f (- n 3))))
  )
)

; Iterative process:
(define (f n)
  (define (f-iter a b c count)
    (cond ((<= count 0) a)
          (else (f-iter (+ a b c) a b (- count 1))))
  )
  (cond ((< n 3) n)
        (else (f-iter 2 1 0 (- n 2))))
)
