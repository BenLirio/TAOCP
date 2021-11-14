/*
Gray binary generation
*/
print_binary:
    str lr, [sp, -16]!
    sub sp, sp, 80
    mov w10, 10
    strb w10, [sp, 64]
    mov x10, 0
1:  cmp x10, 8
    bge 1f
    mov x14, 0
    mov x11, 0
2:  cmp x11, 8
    bge 2f
    mov x12, 43
    tst x1, 1
    csel x12, x12, xzr, ne
    lsr x1, x1, 1
    lsl x14, x14, 8
    orr x14, x14, x12
    add x11, x11, 1
    b   2b
2:
    rev x14, x14
    str x14, [sp, x10, lsl 3]
    add x10, x10, 1
    b   1b
1:
    mov x0, 1
    mov x1, sp
    mov x2, 65
    bl  write
    add sp, sp, 80
    ldr lr, [sp], 16
    ret
    .global main
main:
    str lr, [sp, -16]!
    a .req x20
    j .req x21
G1: mov a, 0
G2: adr x0, fmt
    mov x1, a, lsr 1
    bl print_binary
G3: tst a, 1
    cinc a, a, eq
    cinv a, a, ne
    cinc a, a, ne
    cinv a, a, ne
G4: rbit a, a
    clz j, a
    add j, j, 1
    rbit a, a
G5: cmp j, 64
    bge Done
    mov x10, 1
    lsl x10, x10, j
    tst a, x10
    beq 1f
    bic a, a, x10
    b 2f
1:
    orr a, a, x10
2:
    b G2
Done:
    ldr lr, [sp], 16
    mov x0, 0
    ret
.data
fmt: .asciz "%d\n"
msg: .asciz "hello world\n"
.equ msg_len, (.-msg)
.bss
