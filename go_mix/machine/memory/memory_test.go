package memory

import (
	"testing"
)

func TestMemory(t *testing.T) {
	if len(mainMemory) != 4000 {
		t.Errorf("Main memory should be length 4000, got %d\n", len(mainMemory))
	}
}
