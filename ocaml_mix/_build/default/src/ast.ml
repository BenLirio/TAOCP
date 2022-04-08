type stmt =
  | Nop
  | Enta of int32
  | Entx of int32
  | Lda of int32
  | Sta of int32
  | Add of int32
  | Mul of int32
  | Lbl of string
  | Jmp of string
  | Hlt
type prog = stmt list
