.globl unmarshell

unmarshell:
	sub	sp, sp, 64
	stur	x30, [sp]
	stur	x20, [sp, 8]
	stur	x21, [sp, 16]
	stur	x22, [sp, 24]
	stur	x23, [sp, 32]
	stur	x24, [sp, 40]
	
	mov	x23, 0
	mov	x0, x23
	bl	malloc
	cmp	x0, 0
	b.eq	Error
	mov	x22, x0

	adr	x0, filename
	mov	x1, 0
	bl	open

	mov	x20, x0	// fp
	adr	x10, bufsize
	ldur	x10, [x10]
	sub	sp, sp, x10
	mov	x21, sp // buf

L1:	mov	x0, x20
	mov	x1, x21
	adr	x2, bufsize
	ldur	x2, [x2]
	bl	read
	cmp	x0, 0
	b.eq	DL1
	cmp	x0, -1
	b.eq	Error
	sub	sp, sp, 16
	stur	x0, [sp]

	mov	x24, x23
	add	x23, x23, x0
	mov	x0, x22
	mov	x1, x23
	bl	realloc
	mov	x22, x0
	ldur	x0, [sp]
	add	sp, sp, 16


	mov	x11, x0
	mov	x10, 0
L2:	cmp	x10, x11
	b.ge	DL2
	add	x12, x21, x10
	ldurb	w13, [x12]
	add	x12, x22, x10
	add	x12, x12, x24
	sturb	w13, [x12]
	add	x10, x10, 1
	b	L2
DL2:
	b	L1
DL1:
	adr	x10, bufsize
	ldur	x10, [x10]
	add	sp, sp, x10



	mov	x0, x22
	mov	x1, x23
	ldur	x30, [sp]
	ldur	x20, [sp, 8]
	ldur	x21, [sp, 16]
	ldur	x22, [sp, 24]
	ldur	x23, [sp, 32]
	ldur	x24, [sp, 40]
	add	sp, sp, 64
	ret
Error:	adr	x0, errmsg
	bl	printf
	mov	x0, 1
	mov	x8, 93
	svc	0

.data
	errmsg: .asciz "Error\n"
	s: .asciz "%d\n"
	filename: .asciz "data"
	bufsize: .quad 16
.end
