:- module(check_file,
  [ run/0 ]
).

:- multifile trustyuri_module/1.
:- multifile has_correct_hash/2.

:- consult(rdf/rdf_module).
:- consult(file/file_module).

run :-
  current_prolog_flag(argv, Argv),
  writeln('NOT YET IMPLEMENTED'),
  format('Arguments given: ~w\n', [Argv]).
