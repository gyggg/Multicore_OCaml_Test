# Multicore_OCaml_Test
Run z3 ocaml interface with multicore OCaml.

This program repeatedly calls GC.major in the main thread as well as calling OCaml interface of [Z3](https://github.com/Z3Prover/z3) to solve a problem in subdomains.

This program may trigger a bug at runtime.

## Installation

Install opam2.

Install ocaml-4.12.0+domains : `opam switch create 4.12.0+domains --repositories=multicore=git+https://github.com/ocaml-multicore/multicore-opam.git,default`

Install required packages: `opam install dune z3 domainslib`

Build : `dune build`

Build & Run : `dune exec main`