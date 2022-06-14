type ('k, 'v) map = ('k * 'v) list
val empty_map : 'a list
val is_empty : ('k * 'v) list -> bool
val get : 'k -> ('k * 'v) list -> 'v option
val put : 'k -> 'v -> ('k * 'v) list -> ('k * 'v) list
val contains_key : 'k -> ('k * 'v) list -> bool
val remove : 'k -> ('k * 'v) list -> ('k * 'v) list
val keys : ('k * 'v) list -> 'k list
val values : ('k * 'v) list -> 'v list