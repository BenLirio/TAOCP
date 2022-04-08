open Ast

type reg32 = {get32 : unit -> int32; set32 : int32 -> unit}
type reg64 = {get64 : unit -> int64; set64 : int64 -> unit}

let rIP = ref 0
let _rA = ref 0l
let _rX = ref 0l
let rA =
  { get32=(fun () -> !_rA); set32=(fun v -> _rA := v) }
let rX = 
  { get32=(fun () -> !_rX); set32=(fun v -> _rX := v) }
let rAX = 
  let open Int64 in
  let shl amt v = shift_left v amt in
  let shr amt v = shift_right_logical v amt in
  { get64=(fun () -> 
    logor (!_rA |> of_int32 |> shl 32) (!_rX |> of_int32))
  ; set64=(fun v ->
    _rA := v |> shr 32 |> to_int32;
    _rX := v |> to_int32)
  }

let mem = Array.make 200 0l

type ctxt = string -> int option
let empty_ctxt = fun _ -> None
let extend_ctxt : ctxt -> string -> int -> ctxt = 
  fun c ->
  fun lbl v ->
  fun lbl' ->
  if lbl=lbl'
  then Some v
  else c lbl

let running = ref true

let eval_stmt : ctxt -> stmt array -> unit =
  fun c p ->
  match Array.get p !rIP with
  | Nop -> rIP := !rIP+1
  | Enta op -> rIP:=!rIP+1; rA.set32 op
  | Entx op ->rIP:=!rIP+1;  rX.set32 op
  | Lda op -> rIP:=!rIP+1; rA.set32 @@ Array.get mem (Int32.to_int op)
  | Add op -> rIP:=!rIP+1; rA.set32 @@ Int32.add (rA.get32 ()) (Array.get mem (Int32.to_int op))
  | Mul op -> rIP:=!rIP+1; rA.set32 @@ Int32.mul (rA.get32 ()) (Array.get mem (Int32.to_int op))
  | Sta op -> rIP:=!rIP+1; Array.set mem (Int32.to_int op) (rA.get32 ())
  | Jmp lbl -> 
      (match c lbl with
      | Some loc -> rIP := loc
      | None -> failwith "Invalid label"
      )
  | Lbl _ -> rIP := !rIP+1; ()
  | Hlt ->
      begin 
        rIP := !rIP+1;
        running := false
      end


let eval_prog : prog -> unit = 
  fun prog ->
  let c,_ = List.fold_left (fun (c,i) stmt ->
    (match stmt with
    | Lbl lbl -> extend_ctxt c lbl i
    | _ -> c),(i+1)
  ) (empty_ctxt,0) prog in
  let p = Array.of_list prog in
  while !running do 
    eval_stmt c p 
  done

let parse (s:string) : prog =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let show_state : unit -> unit = fun _ ->
  let open Printf in
  printf "rA=%d\n" (Int32.to_int (rA.get32 ()));
  printf "rX=%d\n" (Int32.to_int (rX.get32 ()))
let reset_state : unit -> unit = fun _ ->
  rAX.set64 0L

let interp (e:string) : unit =
  reset_state ();
  e |> parse |> eval_prog;
  show_state ()

