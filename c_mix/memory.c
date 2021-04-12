#include "constants.h"
#include "memory.h"
#include <stdio.h>

void print_word(word_t word) {
	printf("%d", word.sign.val);
	for (int i = 0; i < WORD_SIZE; i++) {
		printf("|%.2x", word.bytes[i].val);
	}
	printf("\n");
}

word_t word_init() {
	word_t word;
	word.sign.val = DEFAULT_SIGN;
	for (int i = 0; i < WORD_SIZE; i++) {
		word.bytes[i].val = DEFAULT_BYTE;
	}
	return word;
}
