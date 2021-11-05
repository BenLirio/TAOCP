.globl	main
all_functions:
	sub	sp, sp, 32
	stur	x30, [sp]
	mov	x20, 1
	lsl	x10, x20, x0
b:	lsl	x20, x20, x10
	adr	x0, s
	mov	x1, x20
	bl	printf
	ldur	x30, [sp]
	add	sp, sp, 32
	ret
main:
	sub	sp, sp, 32
	stur	x30, [sp]
	mov	x0, 2
	bl	all_functions
	ldur	x30, [sp]
	add	sp, sp, 32
	mov	x0, 0
	ret
.data
	s: .asciz "%lu\n"
