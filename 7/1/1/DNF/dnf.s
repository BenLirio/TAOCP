.globl	dnf

print_as_binary:
	sub	sp, sp, 32
	stur	x30, [sp]
	stur	x20, [sp, 8]

	mov	x0, x20

	ldur	x30, [sp]
	stur	x20, [sp, 8]
	add	sp, sp, 32
	ret
dnf:
	sub	sp, sp, 32
	stur	x30, [sp]
	stur	x20, [sp, 8]
	mov	x20, x0
	mov	x10, 0
L1:	cmp	x10, 63
	b.ge	DL1
	mov	x11, 1
b:	lsl	x11, x11, x10
	and	x11, x20, x11
	cmp	x11, 0
	b.eq	S1
	sub	sp, sp, 32
	stur	x10, [sp]
	mov	x1, x10
	bl	print_as_binary
	ldur	x10, [sp]
	add	sp, sp, 32
S1:
	add	x10, x10, 1
	b	L1
DL1:
	ldur	x30, [sp]
	ldur	x20, [sp, 8]
	add	sp, sp, 32
	ret
.data
	s: .asciz "%d\n"
