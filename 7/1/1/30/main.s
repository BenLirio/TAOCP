.globl main
main:
	sub	sp, sp, 32
	stur	x30, [sp]



	ldur	x30, [sp]
	add	sp, sp, 32

	mov	x0, 0
	ret
.data
	num_variables: 4
	: .byte 1,1,0,0,1,0,0,1,0,0,0,0,1,1,1,1
