(** Runtime validation *)

module Property : sig 

  type t 

  val make_ro : string -> t 
  val make_wo : string -> t 
  val make_rw : string -> t 

  val name : t -> string 

  val read_enabled : t -> bool 
  val write_enabled : t -> bool 

end = struct 

  type access = { 
    read : bool; 
    write : bool 
  }
  
  type t = { 
    access : access; 
    name : string; 
  } 
  
  let make_internal ~read ~write name = { 
    access = { read; write; };
    name; 
  }
  
  let make_ro name = 
    make_internal ~read:true ~write:false name 
  
  let make_wo name  = 
    make_internal ~read:false ~write:true name 
  
  let make_rw name  = 
    make_internal ~read:true ~write:true name 

  let name {name; _ } = name

  let read_enabled {access = {read; _}; _} = read 
  
  let write_enabled {access = {write; _}; _} = write 

end 

(** you can only set a property which is write enabled *)
let set (p:Property.t) v = 
  if Property.write_enabled p
  then ()
  else invalid_arg "set: property is not write enabled"

(** you can only get a property which is read enabled *)
let get (p:Property.t) v = 
  if Property.read_enabled p 
  then 1
  else invalid_arg "get: property is not read enabled"

let () = 

  (* the rules of time are that the past is immutable while 
     * no one can read the future. Only the present can be both read 
     * and written *) 
  let past = Property.make_ro "the_past"  in
  let present = Property.make_rw "the_present"  in
  let future = Property.make_wo "the_future"  in

  (* OK  *) let _ = get past in 
  (* OK  *) let _ = get present in 
  (* EXC *) let _ = get future in 
  (* OK  *) set future 42; 
  (* OK  *) set present 42; 
  (* EXC *) set past 0;
  () 
