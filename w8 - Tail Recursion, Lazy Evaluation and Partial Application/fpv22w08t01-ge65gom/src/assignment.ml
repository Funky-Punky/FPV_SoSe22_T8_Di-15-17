(* Write tail recursive versions of the following functions (without changing their types) *)

 let fac n =
  let rec help acc n = if n = 0 then acc else help (acc * n) (n - 1) in
  help 1 n

let remove a list =
  let rec help acc a list =
    match list with
    | [] -> acc
    | x :: xs -> if x = a then help acc a xs else help (x :: acc) a xs
  in
  List.rev (help [] a list)

let partition pred list =
  let rec help (l1, l2) list =
    match list with
    | [] -> (List.rev l1, List.rev l2)
    | x :: xs ->
        if pred x then help (x :: l1, l2)  xs
        else help (l1, x :: l2)  xs
  in
  help ([], [])  list
