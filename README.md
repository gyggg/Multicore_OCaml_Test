# Multicore_OCaml_Test
Run z3 ocaml interface with multicore OCaml.

## Installation

Install opam2.

Install ocaml-4.12.0+domains : `opam switch create 4.12.0+domains --repositories=multicore=git+https://github.com/ocaml-multicore/multicore-opam.git,default`

Install dune.

Install required packages: `opam install . --deps-only`

Build : `dune build`

Build & Run : `dune exec main`