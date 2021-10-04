open Core
open Domainslib

let pool = Task.setup_pool ~num_additional_domains:16

let rec run_task i =
  let tasks = List.init i ~f:(fun id -> 
      let path = if id % 2 = 0 then "benchmarks/test1.smt2" else "benchmarks/test2.smt2" in
      Task.async pool (fun _ -> 
          let rec loop () = 
            Z3interface.solve_smt2 id path;
            loop () 
          in 
          loop ())) in 
  List.iter tasks ~f:(fun task -> Task.await pool task)

let () = run_task 16