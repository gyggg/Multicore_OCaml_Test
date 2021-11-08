open Z3 
open Mutex

let load_smt2 ctx path =
  SMT.parse_smtlib2_file ctx path [] [] [] []
  |> AST.ASTVector.to_expr_list

let new_instance id =
  let ctx = mk_context [] in 
  let solver = Solver.mk_solver ctx None in 
  ctx, solver, id

let instance_pool = Hashtbl.create 100

let get_instance (id:int) = 
  try Hashtbl.find instance_pool id 
  with _ ->
    Hashtbl.add instance_pool id (new_instance id);
    Hashtbl.find instance_pool id
let mutex = create () 

let solve_smt2 id path =
  lock mutex;
  let ctx, solver, id = get_instance id in
  unlock mutex;
  Solver.reset solver; (** Reset current solver for a new solving *)
  let exprs1 = load_smt2 ctx path in (** Load Z3.expr form smt file *)
  let ret = Solver.check solver exprs1 in 
  match ret with 
    Solver.SATISFIABLE -> 
    let _r = Solver.get_model solver in 
    print_endline @@ Printf.sprintf "[%d] sat" id;
    None
  | Solver.UNSATISFIABLE -> 
    print_endline @@ Printf.sprintf "[%d] unsat" id;
    Some solver
  | Solver.UNKNOWN -> 
    print_endline @@ Printf.sprintf "[%d] unknown" id;
    None
