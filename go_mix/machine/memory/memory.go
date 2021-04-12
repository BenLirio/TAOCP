package memory

import (
	"github.com/BenLirio/TAOCP/mix/machine/word"
)

var mainMemory [4000]*word.Word

func init() {
	for i := range(mainMemory) {
		mainMemory[i] = word.NewWord(5)
	}
}


/*
func Index(idx *word.Word) (*word.Word, error) {
	if idx.Size() != 2 {
		return errors.New(fmt.Sprintf("Error: Can only index with 4 bytes, got %d\n", idx.Size()))
	}
	b := make([]byte, 3)
	idx.Get(&b, 0, 2)
	sign := true
	if b[0] == 1 { sign = false }
	address := int(b[1]) + int(b[2])
	if sign == false { address = -address }
}
*/
