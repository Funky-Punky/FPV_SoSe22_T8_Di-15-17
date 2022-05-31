type vector3 = float * float * float

let p1 = (0., 1., 2.)
let p2 = (-10., -20., -30.)
let p3 = (123.456, 654.321, 0.00001)

let string_of_vector3 (x, y, z) =
  "(" ^ string_of_float x ^ "," ^ string_of_float y ^ "," ^ string_of_float z
  ^ ")"

let vector3_add a b =
  let (a, b, c), (x, y, z) = (a, b) in
  (a +. x, b +. y, c +. z)

let vector3_max v1 v2 =
  match (v1, v2) with
  | (a, b, c), (x, y, z) ->
      if (a *. a) +. (b *. b) +. (c *. c) > (x *. x) +. (y *. y) +. (z *. z)
      then (a, b, c)
      else (x, y, z)

let combine a b c = string_of_vector3 (vector3_add a (vector3_max b c))

(*
   type vector3 = float * float * float

   let p1 = (0., 1., 2.)
   let p2 = (-10., -20., -30.)
   let p3 = (123.456, 654.321, 0.00001)

   let string_of_vector3 (x, y, z) =
     "(" ^ string_of_float x ^ "," ^ string_of_float y ^ "," ^ string_of_float z
     ^ ")"

   let vector3_add (a, b, c) (x, y, z) = (a +. x, b +. y, c +. z)

   let vector3_max (a, b, c) (x, y, z) =
     if (a *. a) +. (b *. b) +. (c *. c) > (x *. x) +. (y *. y) +. (z *. z) then
       (a, b, c)
     else (x, y, z)

   let combine a b c = string_of_vector3 (vector3_add a (vector3_max b c))
*)
