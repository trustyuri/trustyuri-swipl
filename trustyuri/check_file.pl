:- module(check_file, [
  run/0,
  check/1
]).

:- encoding(utf8).

:- use_module(trustyuri_utils).
:- use_module(module_directory).


run :-
  current_prolog_flag(argv, [FileName]),
  check(FileName).


check(FileName) :-
  get_artifactcode(FileName, ArtifactCode),
  sub_string(ArtifactCode, 0, 2, _, ModuleString),
  atom_string(Module, ModuleString),
  open(FileName, read, ContentStream),
  set_stream(ContentStream, encoding(utf8)),
  R = trustyuri_resource(FileName, ContentStream, ArtifactCode),
  (
    has_correct_hash(Module, R),
    !,
    write('Correct hash: ' ),
    writeln(ArtifactCode)
  ;
    writeln('*** INCORRECT HASH ***')
  ),
  close(ContentStream).
