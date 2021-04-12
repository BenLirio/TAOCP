#ifndef MEMORY_H
#define MEMORY_H
#define MEMORY_SLOTS 4000

struct sign {
	unsigned char val : 1;
};
typedef struct sign sign_t;

struct byte {
	unsigned char val : BYTE_SIZE;
};
typedef struct byte byte_t;

struct word {
	sign_t sign;
	byte_t bytes[WORD_SIZE];
};
typedef struct word word_t;

word_t word_init();
void print_word(word_t);
typedef unsigned int val_t;

struct machine {
	word_t rA;
	word_t rX;
	word_t memory[MEMORY_SLOTS];
	int location;
};
typedef struct machine machine_t;

#endif /* MEMORY_H */
