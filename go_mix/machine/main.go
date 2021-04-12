package main

import (
	"fmt"
	"github.com/BenLirio/TAOCP/mix/machine/word"
	"github.com/BenLirio/TAOCP/mix/machine/memory"
	"os"
)

/*
func State() {
	fmt.Printf("reg\tsign\t0\t|1\t |2\t  |3\t   |4\n")
	rA.Print()
	for i, m := range(mem) {
		fmt.Println(m.id)
		m.Print()
		if i == 20 {
			break
		}
	}
}

func Exec(w Word) {
	switch(w.bytes[4]) {
	case 0:
		fmt.Println("NOP")
		break
	case 48:
		fmt.Println("ENTA")
		rA.sign = w.sign
		rA.bytes[0] = w.bytes[0]
		rA.bytes[1] = w.bytes[1]
	default:
		fmt.Println("Error: Unknown instruction")
	}
}
*/

func main() {
	w, err := word.NewWord(5)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	w.Set([]byte{1,2,3}, 0, 3)
	fmt.Println(w)
	fmt.Println(memory.A)
	fmt.Println(memory.B)
}
