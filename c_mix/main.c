#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

#include "constants.h"
#include "instruction.h"
#include "memory.h"
#include "run.h"

void init_memory();
void delay(unsigned int);
machine_t machine;

int main() {
	init_memory();
	if (err != 0) {
		printf("%s\n", err_message);
	}
	for(;;) {
		if (step(&machine) != 0) {
			break;
		}
		if (err != 0) {
			printf("%s\n", err_message);
			return EXIT_FAILURE;
		}
	}
	return EXIT_SUCCESS;
}

void init_memory() {
	machine.rA = word_init();
	for (int i = 0; i < MEMORY_SLOTS; i++) {
		machine.memory[i] = word_init();
	}

	char binary_filename[] = "data.bin";
	int fd = open(binary_filename, O_RDONLY);
	int buf_size = WORD_SIZE + 1; // for sign
	char b[buf_size];
	int n;
	for(int i = 0; (n = read(fd, &b, buf_size)) != 0; i++) {
		if (i >= MEMORY_SLOTS) {
			fprintf(stderr, "Error: Cannot read binary file with more than %d slots\n", MEMORY_SLOTS);
			exit(EXIT_FAILURE);
		}
		if (n == -1) {
			strcpy(err_message, "failed while reading");
			exit(EXIT_FAILURE);
		}
		if (n != buf_size) {
			strcpy(err_message, "invalid word size while reading binary");
			exit(EXIT_FAILURE);
		}
		machine.memory[i].sign.val = b[0]&1;
		for (int j = 0; j < WORD_SIZE; j++) {
			int diff = HOST_BYTE_SIZE - BYTE_SIZE;
			machine.memory[i].bytes[j].val = (b[j+1]<<diff)>>diff;
		}

	}
	close(fd);
}

void delay(unsigned int milliseconds) {
	clock_t start = clock();
	while(clock() < start + milliseconds)
		;;
}
