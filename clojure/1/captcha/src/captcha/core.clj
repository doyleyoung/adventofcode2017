(ns captcha.core
  (:gen-class))

(defn parse-int [s]
    (Integer. (re-find  #"\d+" s )))

(defn seq_captcha [input]
  (let [sum (reduce + (map #(parse-int (get %1 0)) (re-seq #"(\d)(?=\1)" input)))]
    (if (= (first input) (last input))
      (+ sum (parse-int (str (first input))))
      sum)))

(defn matched_items [[v1 & l1] [v2 & l2] result]
  (if (empty? l1)
    result
    (if (= v1 v2)
      (recur l1 l2 (conj result v1))
      (recur l1 l2 result))))

(defn half_captcha [input]
  (let [half (/ (count input) 2)]
    (* 2 (reduce +
           (map #(parse-int (str %1)) (matched_items (subs input 0 half) (subs input half) '()))))))

(defn -main
  "Pass your captcha digits"
  [input]
  (do
    (println (seq_captcha input))
    ;; input is assumed to be even length
    (println (half_captcha input))))
