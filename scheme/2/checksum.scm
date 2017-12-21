#lang racket

(define line_to_num_list
 (lambda (line)
  (map string->number (string-split line))))

(define minmax_diff
 (lambda (nums)
  (- (apply max nums) (apply min nums))))

(define diffs
 (lambda (lines)
  (cond
   ((null? lines) 0)
   (else
    (+ (minmax_diff (line_to_num_list (car lines)))
     (diffs (cdr lines)))))))

(define evenly_divide
 (lambda (nums)
  (cond
   ((null? nums) 0)
   ((eq? (remainder (caar nums) (cadar nums)) 0)
    (/ (caar nums) (cadar nums)))
   ((eq? (remainder (cadar nums) (caar nums)) 0)
    (/ (cadar nums) (caar nums)))
   (else
    (evenly_divide (cdr nums))))))

(define divs
 (lambda (lines)
  (cond
   ((null? lines) 0)
   (else
    (+ (evenly_divide (combinations (line_to_num_list (car lines)) 2))
     (divs (cdr lines)))))))

(define main
 (lambda ()
  (cons
   (diffs (file->lines "../../resources/2/spreadsheet.txt"))
   (divs (file->lines "../../resources/2/spreadsheet.txt")))))