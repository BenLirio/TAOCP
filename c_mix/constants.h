#ifndef CONSTANTS_H
#define CONSTANTS_H

#define MAX_ERROR_MESSAGE 256

#define BYTE_SIZE 6
#define HOST_BYTE_SIZE 8
#define WORD_SIZE 5

#define DEFAULT_SIGN 0
#define DEFAULT_BYTE 0

#define INDEX_BYTE 2
#define FIELDS_BYTE 3
#define OPERATION_BYTE 4
#define ADDRESS_BYTE_0 0
#define ADDRESS_BYTE_1 1

#include "memory.h"

/* GLOBALS */
extern char err_message[MAX_ERROR_MESSAGE];
extern unsigned char err;

#endif /* CONSTANTS_H */
