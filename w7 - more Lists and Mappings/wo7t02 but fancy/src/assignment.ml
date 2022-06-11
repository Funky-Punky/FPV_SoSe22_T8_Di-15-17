type ('k, 'v) map = 'k -> 'v option

let create_empty_map () = fun _ -> None

let get key map = map key
let put key value map = fun k -> if k = key then Some value else map k

let remove key map = fun k -> if k = key then None else map k

