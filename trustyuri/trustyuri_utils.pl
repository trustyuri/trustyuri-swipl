:- module(trustyuri_utils, [
  get_artifactcode/2,
  get_base64/2
]).

:- use_module(library(regex)).

get_artifactcode(TrustyURI, '') :-
  \+ regex('[A-Za-z0-9\\-_]{25,}(\\.[A-Za-z0-9\\-_]{0,20})?', [], TrustyURI, _),
  !.

get_artifactcode(TrustyURI, ArtifactCode) :-
  R = '^(.*[^A-Za-z0-9\\-_])?([A-Za-z0-9\\-_]{25,})(\\.[A-Za-z0-9\\-_]{0,20})?$',
  regex(R, [], TrustyURI, [_,ArtifactCodeString]),
  string_to_atom(ArtifactCodeString, ArtifactCode).


get_base64(Plain, Base64) :-
  base64url(Plain, Base64).

