%{
  open Ast
%}

%token NOP
%token ENTA
%token LDA
%token STA
%token ADD
%token MUL
%token ENTX
%token <int> INT
%token <string> ID
%token COLON
%token CR
%token EOF
%token JMP
%token HLT
%start <Ast.prog> prog


%%

prog:
  | CR p=prog{ Nop::p }
  | s1=stmt CR p=prog { s1::p }
  | s1=stmt EOF { [ s1 ] }
  | EOF { [] }
  ;
stmt:
  | NOP { Nop }
  | ENTA n=INT { Enta(Int32.of_int n)  }
  | ENTX n=INT { Entx(Int32.of_int n)  }
  | LDA n=INT { Lda(Int32.of_int n)  }
  | STA n=INT { Sta(Int32.of_int n)  }
  | ADD n=INT { Add(Int32.of_int n)  }
  | MUL n=INT { Mul(Int32.of_int n)  }
  | JMP lbl=ID { Jmp(lbl) }
  | HLT { Hlt }
  | id=ID COLON { Lbl(id) }
  ;
