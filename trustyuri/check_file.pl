:- module(check_file, [
  run/0,
  check/1
]).

:- use_module(trustyuri_utils).
:- use_module(module_directory).


run :-
  current_prolog_flag(argv, [FileName]),
  check(FileName).


check(FileName) :-
  get_trustyuri_tail(FileName, Tail),
  sub_string(Tail, 0, 2, _, ModuleString),
  atom_string(Module, ModuleString),
  open(FileName, read, In),
  read_string(In, _, Content),
  close(In),
  R = trustyuri_resource(FileName, Content, Tail),
  (
    has_correct_hash(Module, R),
    !,
    write('Correct hash: ' ),
    writeln(Tail)
  ;
    writeln('*** INCORRECT HASH ***')
  ).
