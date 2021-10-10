.globl	main
NextRand:
	sub	sp, sp, 16
	stur	x29, [sp, 8]
	stur	x30, [sp]
	add	x29, sp, 8
	sub	sp, sp, 32
	stur	x20, [sp, 8]
	stur	x21, [sp, 16]
	stur	x22, [sp, 24]

	adr	x10, a
	ldurh	w20, [x10]
	adr	x10, c
	ldurh	w21, [x10]
	adr	x10, m
	ldurh	w22, [x10]
	mul	w0, w0, w20
	add	w0, w0, w21
	udiv	w10, w0, w22
	umsubl	x0, w10, w22, x0

	ldur	x20, [sp, 8]
	ldur	x21, [sp, 16]
	ldur	x22, [sp, 24]
	add	sp, sp, 32
	ldur	x30, [sp]
	ldur	x29, [sp, 8]
	add	sp, sp, 16
	ret
ChiSquareTest:
	sub	sp, sp, 16
	stur	x29, [sp, 8]
	stur	x30, [sp]
	add	x29, sp, 8
	sub	sp, sp, 112
	stur	x30, [sp]
	add	x22, sp, 8

	mov	x20, 0
	mov	x21, 10
L2:	cmp	x20, x21
	b.ge	DL2
	lsl	x10, x20, 3
	add	x10, x22, x10
	stur	xzr, [x10]
	add	x20, x20, 1
	b	L2
DL2:

	mov	x20, 0
	adr	x10, n
	ldur	x21, [x10]
	mov	x0, 0
L0:	cmp	x20, x21
	b.ge	DL0
	bl	NextRand

	mov	x12, 10
	udiv	x10, x0, x12
	umsubl	x10, w10, w12, x0

	lsl	x10, x10, 3
	add	x10, x22, x10
	ldur	x11, [x10]
	add	x11, x11, 1
	stur	x11, [x10]
	add	x20, x20, 1
	b	L0
DL0:
	
	mov	x20, 0
	mov	x21, 10
L1:	cmp	x20, x21
	b.ge	DL1
	lsl	x10, x20, 3
	add	x10, x22, x10
	ldur	x1, [x10]
	adr	x0, s
	bl	printf
	add	x20, x20, 1
	b	L1
DL1:
	add	sp, sp, 112
	ldur	x30, [sp]
	ldur	x29, [sp, 8]
	add	sp, sp, 16
	mov	w0, 0
	ret
main:
	sub	sp, sp, 16
	stur	x29, [sp, 8]
	stur	x30, [sp]
	add	x29, sp, 8
	mov	w0, 1
	bl	ChiSquareTest
	ldur	x29, [sp, 8]
	ldur	x30, [sp]
	add	sp, sp, 16
	mov	w0, 0
	ret
.data
	s: .asciz "%d\n"
	a: .int 1
	c: .int 3
	m: .int 100
	n: .int 2000
