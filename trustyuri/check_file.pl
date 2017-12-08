:- module(check_file, [
  run/0
]).

:- use_module(module_directory).

run :-
  current_prolog_flag(argv, Argv),
  writeln('NOT YET IMPLEMENTED'),
  format('Arguments given: ~w\n', [Argv]),
  writeln('Declared modules:'),
  (
    trustyuri_module(M),
    writeln(M),
    fail
  ;
    true
  ).
