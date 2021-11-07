package main

import (
    "fmt"
    "math/big"
)

func main() {
    for i := 1; i < 100; i++ {
        z := new(big.Float).SetFloat64(float64(i)/100)
        cur := new(big.Float).Copy(z)
        sum := new(big.Float).SetInt64(0)
        for i := 1; i < 1000; i++ {
            cur = cur.Mul(cur, z)
            a := new(big.Float).SetInt64(int64(i))
            sum.Add(sum, new(big.Float).Mul(a, cur))
        }
        fmt.Println(i,"\t", sum)

    }
}
