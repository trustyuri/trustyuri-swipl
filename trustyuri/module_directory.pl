:- module(module_directory, [
  trustyuri_module/1,
  has_correct_hash/2
]).

:- multifile trustyuri_module/1.
:- multifile has_correct_hash/2.

:- consult(rdf/rdf_module).
:- consult(file/file_module).

