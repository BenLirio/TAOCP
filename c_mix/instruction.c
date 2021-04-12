#include "instruction.h"
#include "constants.h"
#include <string.h>
#include <stdio.h>

instruction_t parse_instruction(machine_t *machine) {
	if (machine->location < 0 || machine->location >= MEMORY_SLOTS) {
		strcpy(err_message, "Instruction out of bounds");
		err = 1;
		instruction_t empty_instruction;
		return empty_instruction;
	}
	word_t word = *(machine->memory + machine->location);
	val_t sign = word.sign.val;
	val_t address = (word.bytes[ADDRESS_BYTE_0].val<<BYTE_SIZE) | word.bytes[ADDRESS_BYTE_1].val;
	val_t index = word.bytes[INDEX_BYTE].val;
	val_t fields = word.bytes[FIELDS_BYTE].val;
	val_t operation = word.bytes[OPERATION_BYTE].val;
	instruction_t instruction;
	instruction.sign = sign;
	instruction.address = address;
	instruction.index = index;
	instruction.fields = fields;
	instruction.operation = operation;
	return instruction;
}
unsigned long int get_bytes_val(byte_t *bytes, int start, int end) {
	unsigned long int val = 0;
	if (start == 0) {
		start = 1;
	}
	end--;
	start--;
	for (int i = end; i >= start; i--) {
		val += bytes[i].val<<((end-i)*BYTE_SIZE);
	}
	return val;
}
#define NO_OP 0
#define LDA 8
#define STA 24
#define ADD 1
#define MUL 3
void execute_instruction(instruction_t instruction, machine_t *machine) {
	switch(instruction.operation) {
	case NO_OP:
		printf("NO-OP\n");
		break;
	case LDA:
	{
		printf("LDA\n");
		machine->rA = word_init();
		int end = (instruction.fields%8);
		int start = (instruction.fields - end)/8;
		if (start == 0) {
			machine->rA.sign.val = machine->memory[instruction.address].sign.val;
			start = 1;
		}
		start--;
		int length = end - start;
		int rA_start = WORD_SIZE - length;
		int mem_start = start;
		for (int i = 0; i < length; i++) {
			machine->rA.bytes[rA_start+i].val = machine->memory[instruction.address].bytes[mem_start+i].val;
		}
		break;
	}
	case STA:
	{
		printf("STA\n");
		int end = instruction.fields%8;
		int start = (instruction.fields - end)/8;
		if (start == 0) {
			machine->memory[instruction.address].sign.val = machine->rA.sign.val;
		}
		start--;
		int length = end - start;
		int rA_start = WORD_SIZE - length;
		for (int i = 0; i < length; i++) {
			machine->memory[instruction.address].bytes[start+i].val = machine->rA.bytes[rA_start++].val;
		}

	}
	case ADD:
	{
		printf("ADD\n");
		if (instruction.fields == 6) {
			printf("Floating point not implemented\n");
			break;
		}
		int end = instruction.fields%8;
		int start = (instruction.fields - end)/8;
		int sign = 0;
		if (start == 0) {
			sign = machine->memory[instruction.address].sign.val;
		}
		start--;
		unsigned long int val = 0;
		for (int i = start; i < end; i++) {
			val += machine->memory[instruction.address].bytes[i].val * (1<<(BYTE_SIZE*(i-start)));
		}
		unsigned long int cur = 0;
		for (int i = 0; i < 5; i++) {
			cur += machine->rA.bytes[i].val * (1<<(BYTE_SIZE)*(4-i));
		}
		unsigned long int added_val = val + cur;
		unsigned long int mask = 0;
		for (int i = 0; i < 5; i++) {
			mask = 0;
			for (int j = 0; j < BYTE_SIZE; j++) {
				mask |= 1<<j;
			}
			int shift_size = (4-i)*BYTE_SIZE;
			mask = mask<<(shift_size);
			unsigned char cur_byte = (added_val&mask)>>shift_size;
			machine->rA.bytes[i].val = cur_byte;
		}
	}
	case MUL:
	{
		printf("MUL\n");
		unsigned long int val = get_bytes_val(machine->rA.bytes,0,5);
		printf("%d\n", val);
	}
	}
	machine->location++;
}
