import java.io.File

fun main(args: Array<String>) {
    val inputAsString = File(args.get(0)).bufferedReader().use { it.readText() }
    println(inputAsString)
//    val List<List<String>> lines = inputAsString.map { it.split("\t")}
//    inputAsString.map { println(it.split("\t")) }

//    println(inputAsString)

    println(Combinations(3, 5))
}

class Combinations(val m: Int, val n: Int) {
    private val combination = IntArray(m)

    init {
        generate(0)
    }

    private fun generate(k: Int) {
        if (k >= m) {
            for (i in 0 until m) print("${combination[i]} ")
            println()
        }
        else {
            for (j in 0 until n)
                if (k == 0 || j > combination[k - 1]) {
                    combination[k] = j
                    generate(k + 1)
                }
        }
    }
}