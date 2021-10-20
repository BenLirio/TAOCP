.globl main
main:
	sub	sp, sp, 32
	stur	x30, [sp]
	bl	unmarshell
	bl	printf



	ldur	x30, [sp]
	add	sp, sp, 32

	mov	x0, 0
	ret
