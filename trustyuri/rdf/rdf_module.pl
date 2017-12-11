:- module(rdf_module, [
  has_correct_hash_ra/1
]).

:- use_module(library(semweb/turtle)).

:- use_module(rdf_hasher).

has_correct_hash_ra(trustyuri_resource(_FileName, ContentStream, ArtifactCode)) :-
  rdf_read_turtle(ContentStream, Quads, []),
  make_artifactcode(Quads, ArtifactCodeX),
  ArtifactCode == ArtifactCodeX.
