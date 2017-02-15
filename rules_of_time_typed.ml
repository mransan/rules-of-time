(** Properties are typed with their access rule which could only be 
    read only/write only/read write *)
module Property : sig 

  type -'access t 

  val make_ro : string -> [`Read] t          
  val make_wo : string -> [`Write] t        
  val make_rw : string -> [`Read | `Write] t

  val name : 'access t -> string 

end = struct 

  type 'access t = string 

  let make_ro name = name 
  let make_wo name = name 
  let make_rw name = name 

  let name x = x
end 

(** you can only set a property which is write enabled *)
let set (p : [> `Write] Property.t) v = ()  

(** you can only get a property which is read enabled *)
let get (p : [> `Read ] Property.t) = 1

let () = 

  (* the rules of time are that the past is immutable while 
     * no one can read the future. Only the present can be both read 
     * and written *) 
  let past = Property.make_ro "the_past"  in
  let present = Property.make_rw "the_present"  in
  let future = Property.make_wo "the_future"  in

  (* OK  *) let _ = get past in 
  (* OK  *) let _ = get present in
  (* ERR *) (* let crystall_ball = get future in *) 
  (* OK  *) set future 42; 
  (* OK  *) set present 42; 
  (* ERR *) (* set (past :> [`Write] Property.t) 0; *)
  () 
