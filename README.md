# Multicore_OCaml_Test
Run z3 ocaml interface with multicore OCaml.

This program repeatedly calls GC.major in the main thread as well as calling OCaml interface of [Z3](https://github.com/Z3Prover/z3) to solve a problem in subdomains.

This program may trigger a bug at runtime.

This branch is for the version `379f052ef` of multicore-ocaml.  

## Installation

Install opam2.

Install `ocaml-variants.4.14.0+domains` according https://github.com/ocaml-multicore/ocaml-multicore/blob/5.00/ocaml-variants.opam

Install required packages: `opam install dune z3 domainslib`

Build : `dune build`

Build & Run : `dune exec main`