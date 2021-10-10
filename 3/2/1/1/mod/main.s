	.globl	main
showBinary:
	sub	sp, sp, 32
	stur	x20, [sp, 8]
	stur	x21, [sp, 16]
	stur	x22, [sp, 24]
	stur	x30, [sp]
	mov	x20, 0
	mov	x21, 64
	mov	x22, x0
L0:	cmp	x20, x21
	b.ge	DL0
	mov	x10, 1
	sub	x11, x21, 1
	sub	x11, x11, x20
	lsl	x10, x10, x11
	and	x10, x22, x10
	cmp	x10, 0
	b.eq	E0
	adr	x0, s1
	b	D0
E0:	adr	x0, s0
D0:	bl	printf
	ldur	x30, [sp]
	add	x20, x20, 1
	b	L0
DL0:
	ldur	x20, [sp, 8]
	ldur	x21, [sp, 16]
	ldur	x22, [sp, 24]
	add	sp, sp, 32
	ret
	
main:
	sub	sp, sp, 16
	stur	x30, [sp]
	mov	x0, 9
	bl	showBinary
	ldur	x30, [sp]
	add	sp, sp, 16
	mov	w0, 0
	ret
.data
	s1: .asciz "1"
	s0: .asciz "0"
.end
