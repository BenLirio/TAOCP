    .global main
W:
    cmp x1, 0
    bne 1f
    mov x0, 0
    ret
1:
    x .req x20
    k .req x21
    val .req x22
    stp lr, val, [sp, -16]!
    mov x, x0
    mov k, x1
    stp x, k, [sp, -16]!
    

    eor x10, k, k, lsl 1
    lsr x10, x10, 1
    rev16 x11, x
    rev x11, x11
    rbit x11, x11
    and x10, x11, x10
    and val, x10, 1

    lsl x0, x, 1
    lsr x1, k, 1
    bl  W
    eor x0, x0, val

    ldp x, k, [sp], 16
    ldp lr, val, [sp], 16
    ret

main:
    str lr, [sp, -16]!
    mov x20, 0
1:  cmp x20, 256*256
    bge 1f
    mov x0, x20
    mov x1, 100
    bl  W
    mov x1, x0
    adr x0, fmt
    bl  printf
    add x20, x20, 1
    b   1b
1:


    ldr lr, [sp], 16
    mov x0, 0
    ret
.data
fmt: .asciz "%d"
