
(* The type of tokens. *)

type token = 
  | STA
  | NOP
  | MUL
  | LDA
  | JMP
  | INT of (int)
  | ID of (string)
  | HLT
  | EOF
  | ENTX
  | ENTA
  | CR
  | COLON
  | ADD

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.prog)
