
{
  open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let int = digit+
let id = ['A'-'z']+

rule read =
  parse
  | white    { read lexbuf }
  | "\n"     { CR }
  | "NOP"    { NOP }
  | "ENTA"   { ENTA }
  | "ENTX"   { ENTX }
  | "LDA"    { LDA }
  | "STA"    { STA }
  | "ADD"    { ADD }
  | "MUL"    { MUL }
  | "JMP"    { JMP }
  | "HLT"    { HLT }
  | int      { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | id       { ID (Lexing.lexeme lexbuf) }
  | ":"      { COLON }
  | eof      { EOF }

