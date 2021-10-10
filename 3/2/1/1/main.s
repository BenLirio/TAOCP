	.global main
RANDM:
	ldr	x15, =XRAND
	ldr	w10, [x15]
	umaddl	x10, w10, w0, x1
	str	w10, [x15]
	ret
main:
	sub	sp, sp, #64
	str	x30, [sp, #56]


	ldr	x15, =a
	ldr	w10, [x15]
	ldr	x15, =c
	ldr	w11, [x15]

	mov	w0, w10
	mov	w1, w11
	bl	RANDM

	
	ldr	x30, [sp, #56]
	add	sp, sp, #64
	mov	w0, #0
	ret
.data
	a: .word 7
	c: .word 3
	XRAND:	.word	1
