.globl main
// mvn reverses the bits
func:
	bic	x0, x0, x1
	and	x0, x0, 1
	ret
main:
	sub	sp, sp, 16
	stur	x30, [sp]

	mov	x20, 0
L1:	cmp	x20, 2
	b.ge	DL1
	mov	x21, 0
L2:	cmp	x21, 2
	b.ge	DL2

	mov	x0, x20
	mov	x1, x21
	bl	func
	mov	x1, x0
	adr	x0, s
	bl	printf



	add	x21, x21, 1
	b	L2
DL2:
	add	x20, x20, 1
	b	L1
DL1:
	adr	x0, newline
	bl	printf



	ldur	x30, [sp]
	add	sp, sp, 16
	mov	x0, 0
	ret
.data
	s: .asciz "%d "
	newline: .asciz "\n"
