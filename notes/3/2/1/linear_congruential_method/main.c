#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
#include <stdio.h>

#define NORMALIZE(X) (X)/(float)(unsigned int)(~0)

typedef struct rand_state_t {
	unsigned int a;
	unsigned int c;
	unsigned int cur;
	unsigned int start;
} rand_state_t;

rand_state_t new_rand_state(unsigned int seed) {
	rand_state_t rand_state;
	rand_state.a = 1664525;
	rand_state.c = 1013904223;
	rand_state.cur = seed;
	rand_state.start = seed;
	return rand_state;
}

unsigned int uniform_rand(rand_state_t* s) {
	s->cur = s->a * s->cur + s->c;
	return s->cur;
}

int main() {
	int seed = time(NULL);
	rand_state_t rand_state = new_rand_state(seed);
	float sum = 0;
	int count = 0;
	int print_every = 10;
	for (;;) {
		count++;
		if (count%print_every == 0) {
			printf("%f\n", sum/count);
			//print_every *= 10;
			read(STDIN_FILENO, NULL, 1);
		}
		unsigned int rand_bits = uniform_rand(&rand_state);
		float x = NORMALIZE(rand_bits);
		sum += x;
		fflush(stdout);
	}
}
