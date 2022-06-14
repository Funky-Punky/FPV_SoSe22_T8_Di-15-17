type ('k, 'v) map = 'k -> 'v option

let empty_map _ = None
let get key map = map key
let put key value map k = if k = key then Some value else map k
let remove key map k = if k = key then None else map k

let rec folt f = function
  | [] -> fun b -> b
  | x :: xs -> fun b -> f x (folt f xs b)

let rec fold f list b =
  match list with
  | [] -> b
  | x :: xs ->
      let b' = fold f xs b in
      f x b'
