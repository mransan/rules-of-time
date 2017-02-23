
module Property : sig 

  type +'access t
  
  type 'a r = 'a t constraint 'a = <r:unit; ..>  (* has read prop  *)  
  type 'a w = 'a t constraint 'a = <w:unit; ..>  (* has write prop *)

  val make_ro : string -> <r:unit> t 
  val make_wo : string -> <w:unit> t 
  val make_rw : string -> <r:unit; w:unit> t 

end = struct 

  type +'access t = string

  type 'a r = 'a t constraint 'a = <r:unit; ..>  
  type 'a w = 'a t constraint 'a = <w:unit; ..>

  let make_ro name = name 
  let make_wo name = name
  let make_rw name = name

end 

let get : 'a Property.r -> int = fun _ -> 1 
let set : 'a Property.w -> int -> unit = fun _ _ -> ()

let past = Property.make_ro "past" 
let present = Property.make_rw "present"
let future = Property.make_wo "future"

let () = 
  ignore @@ get past; 
  ignore @@ get present; 
  ignore @@ set present; 
  ignore @@ set future; 

  let _ = [past; (present :> <r:unit> Property.t)] in 
  ()



