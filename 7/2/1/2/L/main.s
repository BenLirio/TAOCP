.global main
main:
    str lr, [sp, -16]!
    j .req x20
    pA .req x21
    l .req x22
    k .req x23
    adr pA, pABase
    sub pA, pA, 8

L1: adr x0, fmt
    ldr x1, [pA, 8]!
    ldr x2, [pA, 8]!
    ldr x3, [pA, 8]!
    ldr x4, [pA, 8]!
    sub pA, pA, 32
    bl printf
L2: mov j, n-1
1:  ldr x10, [pA, j, lsl 3]
    add j, j, 1
    ldr x11, [pA, j, lsl 3]
    sub j, j, 1
    cmp x10, x11
    blt L3
    sub j, j, 1
    cmp j, 0
    beq Terminate
    b   1b
L3: mov l, n
1:  ldr x10, [pA, j, lsl 3]
    ldr x11, [pA, l, lsl 3]
    cmp x10, x11
    cneg l, l, ge
    cinc l, l, ge
    cneg l, l, ge
    bge 1b
    str x11, [pA, j, lsl 3]
    str x10, [pA, l, lsl 3]
L4: add k, j, 1
    mov l, n
1:  cmp k, l
    bge 1f
    ldr x10, [pA, k, lsl 3]
    ldr x11, [pA, l, lsl 3]
    str x11, [pA, k, lsl 3]
    str x10, [pA, l, lsl 3]
    add k, k, 1
    sub l, l, 1
    b 1b
1:
    b L1

    
Terminate:
    ldr lr, [sp], 16
    mov x0, 0
    ret
.data
pABase: .8byte 1,2,3,4
.equ n, (.-pABase)/8
fmt: .asciz "%d %d %d %d\n"
