package memory

import (
	"github.com/BenLirio/TAOCP/mix/machine/word"
)

var rA *word.Word = word.NewWord(5)
var rX *word.Word = word.NewWord(5)
var rI [6]*word.Word
var rJ *word.Word = word.NewWord(2)

func init() {
	for i := range(rI) {
		rI[i] = word.NewWord(2)
	}
}
