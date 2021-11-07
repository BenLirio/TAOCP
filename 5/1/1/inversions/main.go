package main
import (
    "fmt"
)

var saved [][]int

func numInversions(n, k int) int {
    if k < 0 { return 0 }
    if n < 0 { return 0 }
    if saved[n][k] != -1 { return saved[n][k] }
    out := 0
    if n == 1 {
        if k == 0 {
            out = 1
        } else {
            out = 0
        }
    } else {
        for i := 0; i < n; i++ {
            out += numInversions(n-1, k-i)
        }
    }
    saved[n][k] = out
    return saved[n][k]
}

func main() {
    n := 10
    k := (n*(n-1))/2
    saved = make([][]int, n+1)
    for i := 0; i < len(saved); i++ {
        saved[i] = make([]int, k+1)
        for j := 0; j < len(saved[i]); j++ {
            saved[i][j] = -1
        }
    }
    total := 0
    count := 0
    for i := 0; i <= (n*(n-1))/2; i++ {
        inversions := numInversions(n, i)
        total += i*inversions
        count += inversions
    }
    fmt.Println(float64(total)/float64(count))
}
