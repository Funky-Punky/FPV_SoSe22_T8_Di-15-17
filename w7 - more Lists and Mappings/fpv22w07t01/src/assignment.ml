let float_list list = List.map float_of_int list

let to_string list =
  "["
  ^ List.fold_left
      (fun acc element -> acc ^ string_of_int element ^ ";")
      "" list
  ^ "]"

let part_even list =
  let l1, l2 = List.partition (fun x -> x mod 2 = 0) list in
  l1 @ l2

let squaresum list = List.fold_left (fun acc x -> acc + (x * x)) 0 list

(*
 let float_list list = List.map (fun i -> float_of_int i) list

let to_string list =
  "[" ^ List.fold_left (fun s i -> s ^ string_of_int i ^ ";") "" list ^ "]"

let part_even list =
  List.filter (fun x -> x mod 2 = 0) list @ List.filter (fun x -> x mod 2 = 1) list

let squaresum list = List.fold_left (fun acc i -> acc + (i * i)) 0 list 
*)
