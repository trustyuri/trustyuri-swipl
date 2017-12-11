:- module(rdf_preprocessor, [
  preprocess/4
]).

:- encoding(utf8).

:- use_module(rdf_utils).


preprocess([], _ArtifactCode, _BaseUri, []).

preprocess([rdf(S1,P1,O1,G1:_)|RestIn], ArtifactCode, BaseUri, [rdf(S2,P2,O2,G2)|RestOut]) :-
  transform(S1, ArtifactCode, BaseUri, S2),
  transform(P1, ArtifactCode, BaseUri, P2),
  transform_object(O1, ArtifactCode, BaseUri, O2),
  transform(G1, ArtifactCode, BaseUri, G2),
  preprocess(RestIn, ArtifactCode, BaseUri, RestOut).

preprocess([rdf(S1,P1,O1)|RestIn], ArtifactCode, BaseUri, [rdf(S2,P2,O2,'')|RestOut]) :-
  transform(S1, ArtifactCode, BaseUri, S2),
  transform(P1, ArtifactCode, BaseUri, P2),
  transform_object(O1, ArtifactCode, BaseUri, O2),
  preprocess(RestIn, ArtifactCode, BaseUri, RestOut).


transform('', _ArtifactCode, _BaseUri, '') :-
  !.

transform(UriIn, ArtifactCode, '', UriOut) :-
  !,
  normalize(UriIn, ArtifactCode, UriOut).

transform(UriIn, ArtifactCode, BaseUri, UriOut) :-
  !,
  get_trustyuri(UriIn, BaseUri, ArtifactCode, UriOut).


transform_object(UriIn, ArtifactCode, BaseUri, UriOut) :-
  atom(UriIn),
  !,
  transform(UriIn, ArtifactCode, BaseUri, UriOut).

transform_object(node(N), ArtifactCode, BaseUri, UriOut) :-
  !,
  transform(node(N), ArtifactCode, BaseUri, UriOut).

transform_object(Literal, _ArtifactCode, _BaseUri, Literal).


