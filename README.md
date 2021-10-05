# Multicore_OCaml_Test
Run z3 ocaml interface with multicore OCaml.

## Installation

Install opam2.

Install ocaml-4.12.0+domains : `opam switch create 4.12.0+domains --repositories=multicore=git+https://github.com/ocaml-multicore/multicore-opam.git,default`

Install required packages: `opam install dune z3 domainslib core`

Build : `dune build`

Build & Run : `dune exec main`