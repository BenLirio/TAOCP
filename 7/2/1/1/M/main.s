.global main
main:
    str lr, [sp, -16]!
    /* MAIN */
    p_a .req x20
    p_m .req x21
    j .req x22
M1:
    adr p_a, p_a_base
    adr p_m, p_m_base
    mov x10, 2
    str x10, [p_a]
M2:
    adr x0, fmt
    ldr x1, [p_a, 8]!
    ldr x2, [p_a, 8]!
    ldr x3, [p_a, 8]!
    ldr x4, [p_a, 8]!
    ldr x5, [p_a, 8]!
    bl  printf
    adr p_a, p_a_base
M3: 
    mov j, m_size
M4: ldr x10, [p_a, j, lsl 3]
    ldr x11, [p_m, j, lsl 3]
    sub x11, x11, 1
    cmp x10, x11
    bne M5
    str xzr, [p_a, j, lsl 3]
    sub j, j, 1
    b   M4
M5: cmp j, 0
    beq Exit
    ldr x10, [p_a, j, lsl 3]
    add x10, x10, 1
    str x10, [p_a, j, lsl 3]
    b   M2



Exit:
    ldr lr, [sp], 16
    mov x0, 0
    ret
.data
    p_m_base:
    .skip 8
    .8byte 5,4,3,2,1
    .equ m_size, ((.-p_m_base)/8)-1
    fmt: .asciz "%d %d %d %d %d\n"
.bss
    p_a_base: .skip 8*(m_size+1)
.end
