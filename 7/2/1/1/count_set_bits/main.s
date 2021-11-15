    .global main
main:
    str lr, [sp, -16]!
    mov w10, 1
    mov v8.s[0], w10
    mov w10, 2
    mov v8.s[1], w10
    mov w10, 3
    mov v8.s[2], w10
    mov w10, 4
    mov v8.s[3], w10

    mov w10, 1
    mov v9.s[0], w10
    mov w10, 2
    mov v9.s[1], w10
    mov w10, 3
    mov v9.s[2], w10
    mov w10, 4
    mov v9.s[3], w10

    add v10.4s, v8.4s, v9.4s
    adr x0, fmt
    mov w1, v10.s[0]
    mov w2, v10.s[1]
    mov w3, v10.s[2]
    mov w4, v10.s[3]
    bl  printf


    ldr lr, [sp], 16
    mov x0, 0
    ret
.data
fmt: .asciz "%d %d %d %d\n"
