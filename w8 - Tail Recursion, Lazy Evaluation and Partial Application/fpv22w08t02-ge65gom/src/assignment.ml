type 'a llist = Cons of 'a * (unit -> 'a llist)

let rec lnat n = Cons(n, (fun () -> lnat (n+1)))


let rec lfib_help a b = Cons(a, fun () -> lfib_help b (a+b))

let lfib () = lfib_help 0 1

let rec ltake n (Cons(x, f)) = 
  if n = 0 then []
  else x :: (ltake (n - 1) (f ()))

let rec lfilter pred (Cons(x, f)) = 
  if pred x then Cons(x, fun () -> lfilter pred (f ())) 
  else lfilter pred (f ())










(* let rec lnat x = Cons (x, fun () -> lnat (x + 1))
let rec lfib_help x y = Cons (x, fun () -> lfib_help y (y + x))
let lfib () = lfib_help 0 1
let rec ltake n (Cons (x, f)) = if n = 0 then [] else x :: ltake (n - 1) (f ())
let rec lfilter pred (Cons (x, f)) =
  if pred x then Cons (x, fun () -> lfilter pred (f ()))
  else lfilter pred (f ()) *)
