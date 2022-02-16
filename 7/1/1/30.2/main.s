.global _start
_start:

  // Subcube
  // 00 11
  // 11 10
  pushq $0b001
  pushq $0b011
  pushq $0b100
  pushq $0b101
  pushq $0b110
  pushq $5
  call max_sub_cube
  addq $8, %rsp
  addq $8, %rsp
  addq $8, %rsp
  addq $8, %rsp
  addq $8, %rsp
  addq $8, %rsp
  // Expected Subcube
  // 00 bb
  // aa a0

  mov $60, %rax
  mov $0, %rdi
  syscall


max_sub_cube:
  // r10 <- number of 1's
  movq 8(%rsp), %r10
  movq %r10, %r11
  movq %r10, %r12
  shlq $3, %r12
  addq %rsp,%r12

  // Put n-subcubes onto stack
1:
  subq $1, %r11
  cmpq $0, %r11
  jl 1f
  pushq (%r12)
  addq $8,%r12
  jmp 1b
1:

  // Remove n-subcubes from stack
  movq %r10, %r11
1:
  subq $1, %r11
  cmpq $0, %r11
  jl 1f
  popq %rax
  jmp 1b
1:
  
  ret
