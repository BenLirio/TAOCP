.globl	main
main:
	sub	sp, sp, 32
	stur	x30, [sp]

	// Open file
	adr	x0, input_file_name
	mov	x1, 0
	bl	open
	cmp	w0, -1
	b.eq	Error
	mov	x20, x0		// fd = x20

	mov	x0, 0
	bl	malloc
	cmp	x0, -1
	b.eq	Error
	mov	x21, x20	// C = x21

	mov	x0, 0
	bl	malloc
	cmp	x0, -1
	b.eq	Error
	mov	x22, x20	// P = x22
	
	// Read Input
	sub	sp, sp, 512
L1:	mov	x0, x20
	mov	x1, sp
	mov	x2, 512
	bl	read
	cmp	x0, 0
	b.eq	DL1
	cmp	x0, -1
	b.eq	Error
	
	mov	x10, sp
L2:	ldurb	w11, [x10]
	cmp	w11, 0
	b.eq	DL2
	cmp	w11, '\n'


	add	x10, x10, 1
	b	L2
DL2:



	b	L1
DL1:
	add	sp, sp, 512


	b	Done
Error:
	bl	strerror
	bl	printf
Done:
	ldur	x30, [sp]
	add	sp, sp, 32
	mov	x0, 0
	ret
.data
	input_file_name: .asciz "input"
	error: .asciz "Error\n"
	digit: .asciz "%d\n"
	char: .asciz "%c\n"
