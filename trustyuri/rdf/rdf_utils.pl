:- module(rdf_utils, [
  normalize/3,
  get_trustyuri/4
]).

:- use_module(library(regex)).


normalize(Uri, '', Uri) :-
  !.

normalize(Uri, ArtifactCode, Normalized) :-
  atomic_list_concat(L, ArtifactCode, Uri),
  atomic_list_concat(L, ' ', Normalized).


get_trustyuri('', _BaseUri, _ArtifactCode, '') :-
  !,
  fail.

get_trustyuri(node(N), BaseUri, ArtifactCode, TrustyUri) :-
  !,
  expand_baseuri(BaseUri, ExpandedBaseUri),
  atomic_list_concat([ExpandedBaseUri, ArtifactCode, '#_', N], '', TrustyUri).

get_trustyuri(Uri, BaseUri, _ArtifactCode, Uri) :-
  get_suffix(Uri, BaseUri, ''),
  Uri \= BaseUri,
  !.

get_trustyuri(Uri, BaseUri, ArtifactCode, TrustyUri) :-
  get_suffix(Uri, BaseUri, Suffix),
  get_trustyuri_str(BaseUri, ArtifactCode, Suffix, TrustyUri).


get_trustyuri_str(BaseUri, ArtifactCode, '', TrustyUriStr) :-
  !,
  expand_baseuri(BaseUri, ExpandedBaseUri),
  atom_concat(ExpandedBaseUri, ArtifactCode, TrustyUriStr).

get_trustyuri_str(BaseUri, ArtifactCode, Suffix, TrustyUriStr) :-
  atom_concat('_', _, Suffix),
  !,
  expand_baseuri(BaseUri, ExpandedBaseUri),
  % Make two underscores, as one underscore is reserved for blank nodes
  atomic_list_concat([ExpandedBaseUri, ArtifactCode, '#_', Suffix], '', TrustyUriStr).

get_trustyuri_str(BaseUri, ArtifactCode, Suffix, TrustyUriStr) :-
  !,
  expand_baseuri(BaseUri, ExpandedBaseUri),
  atomic_list_concat([ExpandedBaseUri, ArtifactCode, '#', Suffix], '', TrustyUriStr).


get_suffix(PlainUri, BaseUri, Suffix) :-
  atom_concat(BaseUri, Suffix, PlainUri),
  !.

get_suffix(_PlainUri, _BaseUri, '').


expand_baseuri(BaseUri, ExpandedBaseUri) :-
  regex('[A-Za-z0-9\\-_]$', [], BaseUri, []),
  !,
  atom_concat(BaseUri, '.', ExpandedBaseUri).

expand_baseuri(BaseUri, BaseUri).

