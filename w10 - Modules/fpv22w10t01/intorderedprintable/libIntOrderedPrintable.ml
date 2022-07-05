open LibOrderedPrintable

module IntOrderedPrintable : OrderedPrintable with type t = int = struct
  type t = int

  let to_string = string_of_int
  let compare  = Int.compare
end
