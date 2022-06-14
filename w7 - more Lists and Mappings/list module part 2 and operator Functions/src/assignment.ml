let l = [ 1; 2; 3; 4 ]

(* List.map *)

let two_times_l = List.map (fun x -> 2 * x) l

(* List.filter *)

let bigger_than_two = List.filter (fun x -> x > 2) l

(* List.fold_left/right *)

let sum = List.fold_left (fun acc x -> acc + x) 0 l
let rev list = List.fold_right (fun x acc -> x :: acc) [] list

(* Operator Functions *)
(* a+b  =  (+) a b *)
let sum_cooler = List.fold_left ( + ) 0 l

let (+) a b = if a then b else true

