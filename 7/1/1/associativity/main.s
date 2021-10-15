.globl main
func:
	orr	x0, x0, x1
	mvn	x0, x0
	and	x0, x0, 1
	ret
main:
	sub	sp, sp, 32
	stur	x30, [sp]
L0:	cmp	x20, 1
	b.gt	DL0
	mov	x21, 0
L1:	cmp	x21, 1
	b.gt	DL1
	mov	x22, 0
L2:	cmp	x22, 1
	b.gt	DL2

	mov	x0, x20
	mov	x1, x21
	bl	func
	mov	x1, x22
	bl	func
	mov	x23, x0


	mov	x0, x21
	mov	x1, x22
	bl	func
	mov	x1, x0
	mov	x0, x20
	bl	func


	cmp	x0, x23
	b.eq	Same
	adr	x0, error
	mov	x1, x20
	mov	x2, x21
	mov	x3, x22
	bl	printf
Same:



	add	x22, x22, 1
	b	L2
DL2:
	add	x21, x21, 1
	b	L1
DL1:
	add	x20, x20, 1
	b	L0
DL0:
	ldur	x30, [sp]
	sub	sp, sp, 32
	mov	x0, 0
	ret
.data
	error: .asciz "%d %d %d\n"
