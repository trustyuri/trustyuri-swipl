:- module(rdf_preprocessor, [
  preprocess/3
]).

preprocess(_Quads, _ArtifactCode, _BaseUri) :-
  writeln('NOT YET IMPLEMENTED').


transform('', _ArtifactCode, _BaseUri, _BnodeMap) :-
  !.

transform(Uri, ArtifactCode, '', BnodeMap) :-
  writeln('NOT YET IMPLEMENTED'),
  fail.

