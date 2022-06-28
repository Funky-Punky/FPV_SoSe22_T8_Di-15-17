type student = {
  first_name : string;
  last_name : string;
  id : int;
  semester : int;
  grades : (int * float) list;
}

type database = student list

exception Corrupt_database_file
exception My_Corrupt_database_file of string

(* --------------------------------------------------------------------------------
                      _   _     _
   __      __  _ __  (_) | |_  (_)  _ __     __ _
   \ \ /\ / / | '__| | | | __| | | | '_ \   / _` |
    \ V  V /  | |    | | | |_  | | | | | | | (_| |
     \_/\_/   |_|    |_|  \__| |_| |_| |_|  \__, |
                                            |___/
     --------------------------------------------------------------------------------*)

let write_grades_to_channel channel grades =
  List.iter
    (fun (course, grade) ->
      output_string channel
        (string_of_int course ^ ";" ^ string_of_float grade ^ "\n"))
    grades

let write_student_to_channel channel student =
  output_string channel
    (student.first_name ^ ";" ^ student.last_name ^ ";"
   ^ string_of_int student.id ^ ";"
    ^ string_of_int student.semester
    ^ ";"
    ^ string_of_int (List.length student.grades)
    ^ "\n");
  write_grades_to_channel channel student.grades

let rec write_db_to_channel channel db =
  match db with
  | [] -> ()
  | student :: db' ->
      write_student_to_channel channel student;
      write_db_to_channel channel db'

let store_db filename db =
  let channel = open_out filename in
  write_db_to_channel channel db;
  close_out channel

(* --------------------------------------------------------------------------------
                              _   _
    _ __    ___    __ _    __| | (_)  _ __     __ _
   | '__|  / _ \  / _` |  / _` | | | | '_ \   / _` |
   | |    |  __/ | (_| | | (_| | | | | | | | | (_| |
   |_|     \___|  \__,_|  \__,_| |_| |_| |_|  \__, |
                                              |___/
     --------------------------------------------------------------------------------*)
let rec read_grades_from_channel channel count =
  if count = 0 then []
  else
    try
      let contents = String.split_on_char ';' (input_line channel) in
      match contents with
      | [ course_s; grade_s ] -> (
          try
            (int_of_string course_s, float_of_string grade_s)
            :: read_grades_from_channel channel (count - 1)
          with Failure _ ->
            raise (My_Corrupt_database_file "Wrong dataTyre representation"))
      | _ -> raise (My_Corrupt_database_file "One element of the grade list had the wrong format")
    with End_of_file ->
      raise (My_Corrupt_database_file "Not enough grades for Student")

let read_student_from_channel channel =
  let contents = String.split_on_char ';' (input_line channel) in
  match contents with
  | [ first_name; last_name; id_s; semester_s; gradecount_s ] -> (
      try
        {
          first_name;
          last_name;
          id = int_of_string id_s;
          semester = int_of_string semester_s;
          grades = read_grades_from_channel channel (int_of_string gradecount_s);
        }
      with Failure _ ->
        raise (My_Corrupt_database_file "Corrupt Student Data"))
  | _ -> raise (My_Corrupt_database_file "Student line has wrong form")

let rec read_db_from_channel channel =
  try
    let student = read_student_from_channel channel in
    student :: read_db_from_channel channel
  with End_of_file -> []

let my_load_db filename =
  let channel = open_in filename in
  try
    let db = read_db_from_channel channel in
    close_in channel;
    db
  with exn ->
    close_in channel;
    raise exn

let load_db filename =
  try my_load_db filename
  with My_Corrupt_database_file _ -> raise Corrupt_database_file

(* --------------------------------------------------------------------------------
    _                  _     _
   | |_    ___   ___  | |_  (_)  _ __     __ _
   | __|  / _ \ / __| | __| | | | '_ \   / _` |
   | |_  |  __/ \__ \ | |_  | | | | | | | (_| |
    \__|  \___| |___/  \__| |_| |_| |_|  \__, |
                                         |___/
     --------------------------------------------------------------------------------*)
let student_jonas =
  {
    first_name = "Jonas";
    last_name = "Reinstaedtler";
    id = 03742644;
    semester = 4;
    grades = [ (1, 2.3); (2, 5.0); (3, 1.2) ];
  }

let student_max =
  {
    first_name = "Max";
    last_name = "Musterman";
    id = 123456789;
    semester = 3;
    grades = [ (1, 3.0); (2, 2.0); (3, 3.7) ];
  }

let student_frida =
  {
    first_name = "Frida";
    last_name = "Musterman";
    id = 111111111;
    semester = 3;
    grades = [ (1, 3.0); (2, 2.0) ];
  }

let miniTum = [ student_jonas; student_max; student_frida ]
