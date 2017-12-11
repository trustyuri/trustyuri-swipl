:- module(rdf_hasher, [
  make_artifactcode/2
]).

:- use_module(rdf_preprocessor).


make_artifactcode(QuadsIn, ArtifactCode) :-
  preprocess(QuadsIn, ArtifactCode, '', QuadsPre),
  writeln('NOT YET IMPLEMENTED').
