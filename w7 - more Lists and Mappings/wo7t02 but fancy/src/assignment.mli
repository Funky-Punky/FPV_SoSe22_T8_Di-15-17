type ('k, 'v) map = 'k -> 'v option

val create_empty_map : unit -> ('k, 'v) map
val get : 'k -> ('k, 'v) map -> 'v option
val put : 'k -> 'v -> ('k, 'v) map -> ('k, 'v) map
val remove : 'k -> ('k, 'v) map -> ('k, 'v) map