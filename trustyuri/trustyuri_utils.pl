:- module(trustyuri_utils, [
  get_trustyuri_tail/2,
  get_base64/2
]).

:- use_module(library(regex)).

get_trustyuri_tail(TrustyURI, '') :-
  \+ regex('[A-Za-z0-9\\-_]{25,}(\\.[A-Za-z0-9\\-_]{0,20})?', [], TrustyURI, _),
  !.

get_trustyuri_tail(TrustyURI, Tail) :-
  R = '^(.*[^A-Za-z0-9\\-_])?([A-Za-z0-9\\-_]{25,})(\\.[A-Za-z0-9\\-_]{0,20})?$',
  regex(R, [], TrustyURI, [_,TailString]),
  string_to_atom(TailString, Tail).


get_base64(Plain, Base64) :-
  base64url(Plain, Base64).

