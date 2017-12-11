:- module(rdf_utils, [
  normalize/3,
  get_trustyuri/5
]).

:- use_module(library(regex)).


normalize(Uri, '', Uri) :-
  !.

normalize(Uri, ArtifactCode, Normalized) :-
  atomic_list_concat(L, ArtifactCode, Uri),
  atomic_list_concat(L, ' ', Normalized).


get_trustyuri('', _BaseUri, _ArtifactCode, _BnodeMap, '') :-
  !,
  fail.

get_trustyuri(node(N), BaseUri, ArtifactCode, BnodeMap, TrustyUri) :-
  !,
  expand_baseuri(BaseUri, ExpandedBaseUri),
  atomic_list_concat([ExpandedBaseUri, ArtifactCode, '#_', N], '', TrustyUri).

get_trustyuri(Uri, BaseUri, ArtifactCode, BnodeMap, TrustyUri) :-
  !,
  writeln('NOT YET IMPLEMENTED').


expand_baseuri(BaseUri, ExpandedBaseUri) :-
  regex('[A-Za-z0-9\-_]$', [], BaseUri, []),
  !,
  atom_concat(BaseUri, '.', ExpandedBaseUri).

expand_baseuri(BaseUri, BaseUri).

