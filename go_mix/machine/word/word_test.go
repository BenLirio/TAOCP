package word

import (
	"testing"
	"fmt"
)

func TestWord(t *testing.T) {
	w := new(Word)
	w1 := new(Word)
	mb := NewMIXByte(3)
	mb1 := NewMIXByte(3)
	w[0:1] = []MIXByte{mb, mb1}
	fmt.Println(w, w1)
}
