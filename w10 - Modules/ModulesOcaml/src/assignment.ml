module type Collection = sig
  type entry
  type collection

  val create_empty : unit -> collection
  val add : entry -> collection -> collection
  val contains : collection -> entry -> bool
  val size : collection -> int
end

module type Comparable = sig
  type t

  val compare : t -> t -> int
end

module ComparingCollection (E : Comparable) : Collection with type entry = E.t =
struct
  type entry = E.t
  type collection = entry list

  let create_empty () = []

  let rec add entry collection =
    match collection with
    | [] -> [ entry ]
    | x :: xs ->
        if E.compare entry x < 0 then entry :: x :: xs else x :: add entry xs

  let contains collection entry =
    List.find_opt (fun a -> a = entry) collection <> None

  let size = List.length
end

module IntComparable : Comparable with type t = int = struct
  type t = int

  let compare a b = a - b
end

module IntCollection = ComparingCollection (IntComparable)


(*


module type Module = sig
  val foo : int -> int
end

<==>

interface Module {
  int foo(int i);
} 


*)

(* 
module type Module = sig
  include Bar
end

<==>

interface Module implements Bar {
} 
*)

(* 
module Foo : Bar = struct
end

<==> 

class Foo implements Bar {

} 


*)


(* 
module Foo(F : Bar) = struct
end

<==>

class Foo<F extends Bar>{

} 

*)

(* 
Complicated Example:

module ComparingCollection (E : Comparable) : Collection with type entry = E.t =
struct
end
*)