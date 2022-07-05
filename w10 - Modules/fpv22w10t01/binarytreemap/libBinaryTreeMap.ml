open LibPrintable
open LibOrderedPrintable
open LibMap

type ('k, 'v) key_value_pair =
  | Empty
  | Node of ('k * 'v) * ('k, 'v) key_value_pair * ('k, 'v) key_value_pair

module BinaryTreeMap (K : OrderedPrintable) (V : Printable) :
  Map
    with type key = K.t
     and type value = V.t
     (* and type t = (K.t, V.t) key_value_pair  *)
     = struct
  type key = K.t
  type value = V.t
  type t = (key, value) key_value_pair

  let empty = Empty

  let rec set key value map =
    match map with
    | Empty -> Node ((key, value), Empty, Empty)
    | Node ((k, v), left, right) ->
        let dif = K.compare key k in
        if dif = 0 then Node ((k, value), left, right)
        else if dif < 0 then Node ((k, v), set key value left, right)
        else Node ((k, v), left, set key value right)

  let rec get_opt key map =
    match map with
    | Empty -> None
    | Node ((k, v), left, right) ->
        let dif = K.compare key k in
        if dif = 0 then Some v
        else if dif < 0 then get_opt key left
        else get_opt key right

  let get key map =
    match get_opt key map with Some v -> v | None -> raise Not_found

  let rec to_list map =
    match map with
    | Empty -> []
    | Node ((k, v), l, r) -> to_list l @ ((k, v) :: to_list r)

  let to_string m =
    List.map (fun (k, v) -> K.to_string k ^ " -> " ^ V.to_string v) (to_list m)
    |> String.concat ", "
    |> fun s -> "{ " ^ s ^ " }"
end
