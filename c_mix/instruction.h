#ifndef INSTRUCTION_H
#define INSTRUCTION_H
#include "constants.h"
struct instruction {
	val_t sign;
	val_t address;
	val_t index;
	val_t fields;
	val_t operation;
};
typedef struct instruction instruction_t;

instruction_t parse_instruction(machine_t*);
void execute_instruction(instruction_t, machine_t*);
#endif /* INSTRUCTION_H */
