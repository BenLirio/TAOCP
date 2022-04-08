
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | STA
    | NOP
    | MUL
    | LDA
    | JMP
    | INT of (
# 12 "src/parser.mly"
       (int)
# 20 "src/parser.ml"
  )
    | ID of (
# 13 "src/parser.mly"
       (string)
# 25 "src/parser.ml"
  )
    | HLT
    | EOF
    | ENTX
    | ENTA
    | CR
    | COLON
    | ADD
  
end

include MenhirBasics

# 1 "src/parser.mly"
  
  open Ast

# 43 "src/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_prog) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: prog. *)

  | MenhirState18 : (('s, _menhir_box_prog) _menhir_cell1_CR, _menhir_box_prog) _menhir_state
    (** State 18.
        Stack shape : CR.
        Start symbol: prog. *)

  | MenhirState23 : (('s, _menhir_box_prog) _menhir_cell1_stmt, _menhir_box_prog) _menhir_state
    (** State 23.
        Stack shape : stmt.
        Start symbol: prog. *)


and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Ast.stmt)

and ('s, 'r) _menhir_cell1_CR = 
  | MenhirCell1_CR of 's * ('s, 'r) _menhir_state

and _menhir_box_prog = 
  | MenhirBox_prog of (Ast.prog) [@@unboxed]

let _menhir_action_01 =
  fun p ->
    (
# 25 "src/parser.mly"
             ( Nop::p )
# 76 "src/parser.ml"
     : (Ast.prog))

let _menhir_action_02 =
  fun p s1 ->
    (
# 26 "src/parser.mly"
                      ( s1::p )
# 84 "src/parser.ml"
     : (Ast.prog))

let _menhir_action_03 =
  fun s1 ->
    (
# 27 "src/parser.mly"
                ( [ s1 ] )
# 92 "src/parser.ml"
     : (Ast.prog))

let _menhir_action_04 =
  fun () ->
    (
# 28 "src/parser.mly"
        ( [] )
# 100 "src/parser.ml"
     : (Ast.prog))

let _menhir_action_05 =
  fun () ->
    (
# 31 "src/parser.mly"
        ( Nop )
# 108 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_06 =
  fun n ->
    (
# 32 "src/parser.mly"
               ( Enta(Int32.of_int n)  )
# 116 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_07 =
  fun n ->
    (
# 33 "src/parser.mly"
               ( Entx(Int32.of_int n)  )
# 124 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_08 =
  fun n ->
    (
# 34 "src/parser.mly"
              ( Lda(Int32.of_int n)  )
# 132 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_09 =
  fun n ->
    (
# 35 "src/parser.mly"
              ( Sta(Int32.of_int n)  )
# 140 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_10 =
  fun n ->
    (
# 36 "src/parser.mly"
              ( Add(Int32.of_int n)  )
# 148 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_11 =
  fun n ->
    (
# 37 "src/parser.mly"
              ( Mul(Int32.of_int n)  )
# 156 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_12 =
  fun lbl ->
    (
# 38 "src/parser.mly"
               ( Jmp(lbl) )
# 164 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_13 =
  fun () ->
    (
# 39 "src/parser.mly"
        ( Hlt )
# 172 "src/parser.ml"
     : (Ast.stmt))

let _menhir_action_14 =
  fun id ->
    (
# 40 "src/parser.mly"
                ( Lbl(id) )
# 180 "src/parser.ml"
     : (Ast.stmt))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ADD ->
        "ADD"
    | COLON ->
        "COLON"
    | CR ->
        "CR"
    | ENTA ->
        "ENTA"
    | ENTX ->
        "ENTX"
    | EOF ->
        "EOF"
    | HLT ->
        "HLT"
    | ID _ ->
        "ID"
    | INT _ ->
        "INT"
    | JMP ->
        "JMP"
    | LDA ->
        "LDA"
    | MUL ->
        "MUL"
    | NOP ->
        "NOP"
    | STA ->
        "STA"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_26_spec_00 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      MenhirBox_prog _v
  
  let rec _menhir_goto_prog : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_26_spec_00 _menhir_stack _v
      | MenhirState18 ->
          _menhir_run_25 _menhir_stack _v
      | MenhirState23 ->
          _menhir_run_24 _menhir_stack _v
  
  and _menhir_run_25 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_CR -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let MenhirCell1_CR (_menhir_stack, _menhir_s) = _menhir_stack in
      let p = _v in
      let _v = _menhir_action_01 p in
      _menhir_goto_prog _menhir_stack _v _menhir_s
  
  and _menhir_run_24 : type  ttv_stack. (ttv_stack, _menhir_box_prog) _menhir_cell1_stmt -> _ -> _menhir_box_prog =
    fun _menhir_stack _v ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, s1) = _menhir_stack in
      let p = _v in
      let _v = _menhir_action_02 p s1 in
      _menhir_goto_prog _menhir_stack _v _menhir_s
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_09 n in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let s1 = _v in
          let _v = _menhir_action_03 s1 in
          _menhir_goto_prog _menhir_stack _v _menhir_s
      | CR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STA ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | NOP ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_05 () in
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23 _tok
          | MUL ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | LDA ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | JMP ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | ID _v_1 ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState23
          | HLT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_13 () in
              _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23 _tok
          | EOF ->
              let _v = _menhir_action_04 () in
              _menhir_run_24 _menhir_stack _v
          | ENTX ->
              _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | ENTA ->
              _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | CR ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | ADD ->
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState23
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_11 n in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_08 n in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let lbl = _v in
          let _v = _menhir_action_12 lbl in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v in
          let _v = _menhir_action_14 id in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_07 n in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_16 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_06 n in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STA ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | NOP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_05 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18 _tok
      | MUL ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | LDA ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | JMP ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | ID _v ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18
      | HLT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_13 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18 _tok
      | EOF ->
          let _v = _menhir_action_04 () in
          _menhir_run_25 _menhir_stack _v
      | ENTX ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | ENTA ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | CR ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | ADD ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
      | _ ->
          _eRR ()
  
  and _menhir_run_19 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_prog) _menhir_state -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_10 n in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_prog =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STA ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | NOP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_05 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | MUL ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | LDA ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | JMP ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | ID _v ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | HLT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_13 () in
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | EOF ->
          let _v = _menhir_action_04 () in
          _menhir_run_26_spec_00 _menhir_stack _v
      | ENTX ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | ENTA ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | CR ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | ADD ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | _ ->
          _eRR ()
  
end

let prog =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_prog v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
