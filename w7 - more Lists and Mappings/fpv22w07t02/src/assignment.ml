type ('k, 'v) map = ('k * 'v) list

let empty_map = []
let is_empty map = map = []

let rec get key map =
  match map with
  | [] -> None
  | (k, v) :: map' -> if k = key then Some v else get key map'

let remove key map = List.filter (fun (k, _) -> k <> key) map
let put key value map = (key, value) :: remove key map
let contains_key key map = get key map <> None
let keys map = List.map fst map
let values map = List.map snd map

(*
   let empty_map = []
   let is_empty map = if map = [] then true else false

   let rec get key map =
     match map with
     | [] -> None
     | (k, v) :: map' -> if key = k then Some v else get key map'

   let rec remove key map =
     match map with
     | [] -> []
     | (k, v) :: map' ->
         if key = k then remove key map' else (k, v) :: remove key map'

   let put key value map = (key, value) :: remove key map
   let contains_key key map = get key map <> None
   let keys map = List.map fst map
   let values map = List.map snd map
*)
