open Domainslib

let max = 1
let mutex = Mutex.create ()
let path = "benchmarks/test.smt2"
let running_states = Atomic.make @@ Array.create (max + 1) false
let set_running_state id state = 
  Mutex.lock mutex;
  Array.set (Atomic.get running_states) id state;
  Mutex.unlock mutex
let get_running_state id = 
  Mutex.lock mutex;
  let state = Array.get (Atomic.get running_states) id in 
  Mutex.unlock mutex;
  state
let pool = Task.setup_pool ~num_additional_domains:2 ()
let rec call_z3 id=
  let ret = Z3interface.solve_smt2 id path in
  begin match ret with 
    | None -> () 
    | Some solver -> ignore @@ Z3.Solver.get_unsat_core solver end;
  set_running_state id false

let rec loop_run_task i =
  Gc.major(); (* To simulate that gc was called at some point in the main thread *)
  let _ = List.init i (fun id -> 
      if get_running_state id then None 
      else begin
        set_running_state id true;
        Some (Task.async pool (fun _ -> call_z3 id)) 
      end) in 
  loop_run_task i

let () = loop_run_task max