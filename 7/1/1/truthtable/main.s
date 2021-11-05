.globl	main
permutations:
	sub	sp, sp, 32
	stur	x30, [sp]

	mov	x20, x0
	mov	x21, 1
	lsl	x21, x21, x20
	mov	x22, 0
L1:	cmp	x22, x21
	b.ge	DL1
	mov	x23, 0
L2:	cmp	x23, x20
	b.ge	DL2
	mov	x10, 1
	lsl	x10, x10, x23
	and	x10, x10, x22
	lsr	x10, x10, x23
	adr	x0, s
	mov	x1, x10
	bl	printf
	add	x23, x23, 1
	b	L2
DL2:
	adr	x0, newline
	bl	printf
	add	x22, x22, 1
	b	L1
DL1:


	ldur	x30, [sp]
	add	sp, sp, 32
	ret
main:
	sub	sp, sp, 32
	stur	x30, [sp]
	adr	x0, s
	mov	x1, 0
	stur	x1, [sp, 8]
	add	x1, sp, 8
b:	bl	scanf
	ldur	x0, [sp, 8]
	bl	permutations
	ldur	x30, [sp]
	add	sp, sp, 32
	mov	x0, 0
	ret
.data
	s: .asciz "%d"
	newline: .asciz "\n"
