    .global main

even_bits:
    nbits .req x10
    mov nbits, 0
1:  cmp x0, 0
    beq 1f
    tst x0, 1
    cinc nbits, nbits, ne
    lsr x0, x0, 1
    b 1b
1:
    and x0, nbits, 1
    ret
main:
    str lr, [sp, -16]!

    x .req x20
    k .req x21

    mov x, 0
    mov k, 20
1:
    cmp x, 256
    bge 1f
    rbit x10, k
    rev x10, x10
    and x0, x10, x
    bl even_bits
    mov x1, x0
    adr x0, fmt
    bl printf
    add x, x, 1
    b 1b
1:

    ldr lr, [sp], 16
    mov x0, 0
    ret
.data
fmt: .asciz "%d"
