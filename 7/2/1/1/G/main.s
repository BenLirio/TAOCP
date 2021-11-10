    .global main
main:
    str lr, [sp, -16]!
    a .req x20
    j .req x21
G1: mov a, 0
G2: adr x0, fmt
    mov x1, a, lsr 1
    bl printf
G3: tst a, 1
    cinc a, a, eq
    cinv a, a, ne
    cinc a, a, ne
    cinv a, a, ne
G4: rbit a, a
    clz j, a
    add j, j, 1
    rbit a, a
G5: cmp j, 4
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
.bss
