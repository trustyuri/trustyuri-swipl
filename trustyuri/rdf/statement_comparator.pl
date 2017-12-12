:- module(statement_comparator, [
  compare_statements/3,
  set_current_artifact_code/1
]).

:- encoding(utf8).


:- thread_local current_artifact_code/1.

current_artifact_code('').


set_current_artifact_code(ArtifactCode) :-
  retractall(current_artifact_code(_)),
  assert(current_artifact_code(ArtifactCode)),
  !.


compare_statements(D, rdf(_,_,_,G1), rdf(_,_,_,G2)) :-
  compare_context(D, G1, G2),
  D \= '=',
  !.

compare_statements(D, rdf(S1,_,_,_), rdf(S2,_,_,_)) :-
  compare_uri(D, S1, S2),
  D \= '=',
  !.

compare_statements(D, rdf(_,P1,_,_), rdf(_,P2,_,_)) :-
  compare_uri(D, P1, P2),
  D \= '=',
  !.

compare_statements(D, rdf(_,_,O1,_), rdf(_,_,O2,_)) :-
  compare_object(D, O1, O2).


compare_context('=', '', '') :-
  !.

compare_context('<', '', _) :-
  !.

compare_context('>', _, '') :-
  !.

compare_context(D, Context1, Context2) :-
  compare_uri(D, Context1, Context2).


compare_object('>', literal(_), Uri) :-
  atom(Uri),
  !.

compare_object('<', Uri, literal(_)) :-
  atom(Uri),
  !.

compare_object(D, literal(L1), literal(L2)) :-
  !,
  compare_literal(D, L1, L2).

compare_object(D, Uri1, Uri2) :-
  compare_uri(D, Uri1, Uri2).


compare_literal(D, L1, L2) :-
  get_literal_value(L1, V1),
  get_literal_value(L2, V2),
  compare(D, V1, V2),
  D \= '=',
  !.

compare_literal('<', L1, L2) :-
  get_literal_datatype(L1, ''),
  get_literal_datatype(L2, T2),
  T2 \= '',
  !.

compare_literal('>', L1, L2) :-
  get_literal_datatype(L1, T1),
  get_literal_datatype(L2, ''),
  T1 \= '',
  !.

compare_literal(D, L1, L2) :-
  get_literal_datatype(L1, T1),
  get_literal_datatype(L2, T2),
  compare(D, T1, T2),
  D \= '=',
  !.

compare_literal('<', L1, L2) :-
  get_literal_language(L1, ''),
  get_literal_language(L2, Lang2),
  Lang2 \= '',
  !.

compare_literal('>', L1, L2) :-
  get_literal_language(L1, Lang1),
  get_literal_language(L2, ''),
  Lang1 \= '',
  !.

compare_literal(D, L1, L2) :-
  get_literal_language(L1, Lang1),
  get_literal_language(L2, Lang2),
  compare(D, Lang1, Lang2).


get_literal_value(type(_, Value), Value) :-
  !.

get_literal_value(lang(_, Value), Value) :-
  !.

get_literal_value(Value, Value).


get_literal_datatype(type(Type, _), Type) :-
  !.

get_literal_datatype(lang(_, _), '') :-
  !.

get_literal_datatype(_, 'http://www.w3.org/2001/XMLSchema#string').


get_literal_language(type(_, _), '') :-
  !.

get_literal_language(lang(Lang, _), Lang) :-
  !.

get_literal_language(_, '').


compare_uri(D, Uri1, Uri2) :-
  current_artifact_code(''),
  !,
  compare(D, Uri1, Uri2).

compare_uri(D, Uri1, Uri2) :-
  current_artifact_code(ArtifactCode),
  !,
  atomic_list_concat(L1, ArtifactCode, Uri1),
  atomic_list_concat(L1, ' ', Uri1N),
  atomic_list_concat(L2, ArtifactCode, Uri2),
  atomic_list_concat(L2, ' ', Uri2N),
  compare(D, Uri1N, Uri2N).

