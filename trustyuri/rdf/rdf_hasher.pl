:- module(rdf_hasher, [
  make_artifactcode/2
]).

:- encoding(utf8).

:- use_module(rdf_preprocessor).
:- use_module(statement_comparator).


make_artifactcode(QuadsIn, ArtifactCode) :-
  preprocess(QuadsIn, ArtifactCode, '', QuadsPre),
  set_current_artifact_code(ArtifactCode),
  predsort(compare_statements, QuadsPre, QuadsSorted),
  writeln('sorted:'),
  writeln(QuadsSorted),
  writeln('NOT YET IMPLEMENTED').
