(ns checksum.core
  (:require [clojure.math.combinatorics :as combo]))

(defn parse-int [s]
  (Integer. (re-find  #"\d+" s )))

(defn diffs [lines]
  (reduce + (map #(- (apply max %) (apply min %)) lines)))

(defn analyze_combo [[combo & remaining]]
  (cond
    (empty? combo)
      0
    (= 0 (rem (first combo) (second combo)))
      (/ (first combo) (second combo))
    (= 0 (rem (second combo) (first combo)))
      (/ (second combo) (first combo))
    :else (recur remaining)))

(defn analyze_combos [total [current & remaining]]
  (if (empty? current)
    total
    (recur (+ total (analyze_combo current)) remaining)))

(defn divs [lines]
  (analyze_combos 0 (map #(combo/combinations % 2) lines)))

(defn -main
  "Performs two types of checksum on and example spreadsheet"
  []
  (with-open [rdr (clojure.java.io/reader "../../../resources/2/spreadsheet.txt")]
    ;; read input file, split lines on space, convert string digits to integers
    (let [lofl (map #(map parse-int %) (map #(clojure.string/split % #"\s+") (reduce conj [] (line-seq rdr))))]
      (do
        (println (diffs lofl))
        (println (divs lofl))))))