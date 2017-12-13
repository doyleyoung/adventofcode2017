(ns captcha.core
  (:gen-class))

(defn parse-int [s]
    (Integer. (re-find  #"\d+" s )))

(defn seq_captcha [input]
  (let [sum (reduce + (map #(parse-int (get %1 0)) (re-seq #"(\d)(?=\1)" input)))]
    (if (= (first input) (last input))
      (+ sum (parse-int (str (first input))))
      sum
    )
  )
)

(defn matched_items [l1 l2 result]
  (if (empty? l1)
    result
    (if (= (first l1) (first l2))
      (recur (rest l1) (rest l2) (conj result (first l1)))
      (recur (rest l1) (rest l2) result)
    )
  )
)

(defn half_captcha [input]
  (let [half (/ (count input) 2)
        first_half (subs input 0 half)
        second_half (subs input half)]
    (* 2 (reduce + (map #(parse-int (str %1)) (matched_items first_half second_half '()))))
  )
)

(defn -main
  "Pass your captcha digits"
  [input]
  (do
    (println (seq_captcha input))
    ;; input is assumed to be even length
    (println (str (half_captcha input)))))
