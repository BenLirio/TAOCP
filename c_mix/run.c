#include "run.h"
#include "instruction.h"
#include <stdio.h>
#include <unistd.h>
#include "constants.h"
#include "memory.h"
#include "string.h"
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>
#include <fcntl.h>

#define MAX_LINE 512
#define MAX_ARGS 16
enum CMD {STEP, STOP, USAGE, PRINT};

struct cmd {
	int argc;
	char argv[MAX_ARGS][MAX_LINE];
};
typedef struct cmd cmd_t;

cmd_t get_cmd();
void execute_cmd(cmd_t, machine_t*);
void usage();

int step(machine_t *machine) {
	cmd_t cmd = get_cmd();
	execute_cmd(cmd, machine);
	return 0;
}

cmd_t get_cmd() {
	char b[MAX_LINE];
	size_t n;
	n = read(0, &b, MAX_LINE);
	cmd_t cmd;
	cmd.argc = 0;
	int word_start = 0;
	int blank_space = 1;
	for (int i = 0; i < n; i++) {
		if (b[i] == ' ' || b[i] == '\t' || b[i] == '\n') {
			if (blank_space == 0) {
				b[i] = '\0';
				cmd.argv[cmd.argc][i-word_start] = '\0';
				strncpy(cmd.argv[cmd.argc++], b+word_start, i - word_start);
			}
			blank_space = 1;
			continue;
		} else {
			if (blank_space == 1) {
				word_start = i;
			}
			blank_space = 0;
		}
	}
	return cmd;
}

void execute_cmd(cmd_t cmd, machine_t *machine) {
	if (cmd.argc <= 0) {
		usage();
		return;
	}
	if (strcmp("print", cmd.argv[0]) == 0) {
		if (cmd.argc <= 1) {
			printf("Usage: print [ rA | rX | memory ]\n");
			return;
		}
		if (strcmp("rA", cmd.argv[1]) == 0) {
			print_word(machine->rA);
			return;
		}
		if (strcmp("rX", cmd.argv[1]) == 0) {
			print_word(machine->rX);
			return;
		}
		if (strcmp("memory", cmd.argv[1]) == 0) {
			int num_to_print = MEMORY_SLOTS;
			int start_at = 0;
			if (cmd.argc >= 3) {
				num_to_print = atoi(cmd.argv[2]);
				if (cmd.argc >= 4) {
					start_at = num_to_print;
					num_to_print = atoi(cmd.argv[3]);
				}
			}
			for (int i = start_at; i < num_to_print; i++) {
				print_word(machine->memory[i]);
			}
			return;
		}
		
	}
	if (strcmp("step", cmd.argv[0]) == 0) {
		instruction_t instruction;
		instruction = parse_instruction(machine);
		execute_instruction(instruction, machine);
		return;
	}
	if (strcmp("quit", cmd.argv[0]) == 0) {
		exit(EXIT_SUCCESS);
		return;
	}
	if (strcmp("help", cmd.argv[0]) == 0) {
		printf("HELP\n");
		return;
	}
	if (strcmp("dump", cmd.argv[0]) == 0) {
		if (cmd.argc != 2) {
			printf("dump [ file name ]\n");
			return;
		}
		struct stat sb;
		if ((stat(cmd.argv[1], &sb) != -1)) {
			fprintf(stderr, "Warning: File %s already exists. Would you like to overwrite [N/y] ", cmd.argv[1]);
			cmd_t overwrite_cmd = get_cmd();
			if (overwrite_cmd.argc != 1 || strcmp(overwrite_cmd.argv[0], "y") != 0) {
				printf("Aborting dump\n");
				return;
			}
		}
		int dump_fd = open(cmd.argv[1], O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
		char b[WORD_SIZE];
		for (int i = 0; i < MEMORY_SLOTS; i++) {
			b[0] = machine->memory[i].sign.val;
			for (int j = 0; j < WORD_SIZE; j++) {
				b[j] = machine->memory[i].bytes[j].val;
			}
			int n = write(dump_fd, b, WORD_SIZE);
			if (n < 0) {
				fprintf(stderr, "Error: Failed write. %s.\n", strerror(errno));
				break;
			}
			if (n != WORD_SIZE) {
				fprintf(stderr, "Error: Failed to write a valid word of size %d\n", WORD_SIZE);
			}
		}
		printf("Dumped memory to '%s'\n", cmd.argv[1]);
		close(dump_fd);
	}
}

void usage() {
	printf("Usage: [ print | step | quit ]\nType help for more\n");
}
