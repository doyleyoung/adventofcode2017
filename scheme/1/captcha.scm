#lang racket

(define char_to_number
 (lambda (c)
  (string->number (string c))
 )
)

(define sum_pairs
 (lambda (input)
  (cond
   ((null? (car input)) 0)
   ((null? (cdr input)) 0)
   ((eq? (car input) (cadr input))
    (+ (char_to_number (car input)) (sum_pairs (cdr input))))
   (else
    (sum_pairs (cdr input))))))

(define seq_captcha
 (lambda (input)
  (if (equal? (substring input 0 1) (substring input (- (string-length input) 1)))
   (+ (string->number (substring input 0 1)) (sum_pairs (string->list input)))
   (sum_pairs (string->list input))
  )
 )
)

(define matched_items
 (lambda (l1 l2)
  (cond
   ((null? l1) '())
   ((eq? (car l1) (car l2))
    (cons (car l1) (matched_items (cdr l1) (cdr l2))))
   (else
    (matched_items (cdr l1) (cdr l2))))))

(define half_captcha
 (lambda (input)
  (let ([half (/ (string-length input) 2)])
   (* 2 (foldl + 0
         (matched_items
          (map char_to_number (string->list (substring input 0 half)))
          (map char_to_number (string->list (substring input half)))))))))

(define main
 (lambda (input)
  (cons
   (seq_captcha input)
   (half_captcha input))))