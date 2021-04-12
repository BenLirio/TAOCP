#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <fcntl.h>

#define BUF_SIZE 2048
#define BYTE_SIZE 6

int main() {
	char b[BUF_SIZE];
	char out_b[BUF_SIZE];
	int out_fd, in_fd;
	int n;
	char out_file[] = "data.bin";
	char in_file[] = "data";
	if ((in_fd = open(in_file, O_RDONLY)) == -1) {
		fprintf(stderr, "Failed to open %s. %s.\n", in_file, strerror(errno));
		return EXIT_FAILURE;
	}
	if ((out_fd = open(out_file, O_CREAT|O_TRUNC|O_RDWR, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)) == -1) {
		fprintf(stderr, "Failed to open %s. %s.\n", out_file, strerror(errno));
		return EXIT_FAILURE;
	}
	int first_digit = 1;
	unsigned char cur = 0;
	for(;;) {
		n = read(in_fd, b, BUF_SIZE);
		if (n < 0) {
			fprintf(stderr, "Error: Couln't read file. %s.\n", strerror(errno));
			break;
		}
		if (n == 0) {
			break;
		}
		for (int i = 0; i < n; i++) {
			if (isxdigit(b[i])) {
				char digit_str[2];
				digit_str[0] = b[i];
				digit_str[1] = '\0';
				unsigned char val = (unsigned char)strtol(digit_str, NULL, 16);
				cur = first_digit ? val << 4 : cur + val;
				if (first_digit == 0) {
					if (cur >= 1<<BYTE_SIZE) {
						fprintf(stderr, "Warning: Writting byte of size %d is undefined.\n", cur);
					}
					write(out_fd, &cur, 1);
				}
				first_digit = first_digit ? 0 : 1;
			}
		}
	}
	if (close(out_fd) == -1) {
		fprintf(stderr, "Error: Couln't close %s. %s.\n", out_file, strerror(errno));
		return EXIT_FAILURE;
	}
	if (close(in_fd) == -1) {
		fprintf(stderr, "Error: Couln't close %s. %s.\n", out_file, strerror(errno));
		return EXIT_FAILURE;
	}

}
