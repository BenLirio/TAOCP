(* Boolean functions *)
let funcs = [
    ("conjunction", (fun a b -> if (a = true) && (b = true) then true else false));
    ("disjunction", (fun a b -> if a = false && b = false then false else true));
    ("nonimplication", (fun a b -> if a = true && b = false then true else false));
    ("converse_nonimplication", (fun a b -> if a = false && b = true then true else false));
    ("exclusive_disjunction", (fun a b -> if a = b then false else true))
]
let get_func name =
    let rec aux name = function
        | [] -> assert false
        | (name', func) :: t -> if name = name' then (name, func) else aux name t
    in aux name funcs

(* Truth table representation *)
let x = [false; false; true; true]

(* Base variables *)
let x = [
    [false; false; true; true];
    [false; true; false; true]
]

(* Wanted truth table *)
let y = [false; false; true; false]

(* Example chain *)
let chain = [(get_func "conjunction", 0, 1); (get_func "disjunction", 1, 2)]

let get_min_chain x y =
    let rec aux x y = 

let () =
    List.iter (fun ((func_name, _), a, b) -> Printf.printf "%s %d %d\n" func_name a b) (get_min_chain x y)
