:- module(rdf_hasher, [
  make_artifactcode/3
]).

:- encoding(utf8).

:- use_module(library(sha)).

:- use_module('../trustyuri_utils').
:- use_module(rdf_preprocessor).
:- use_module(statement_comparator).


make_artifactcode(QuadsIn, ArtifactCodeSeen, ArtifactCodeMade) :-
  preprocess(QuadsIn, ArtifactCodeSeen, '', QuadsPre),
  set_current_artifact_code(ArtifactCodeSeen),
  predsort(compare_statements, QuadsPre, QuadsSorted),
  serialize(QuadsSorted, Serialized),
  % Uncomment next line to see what goes into the has
  %writeln('-----'), write(Serialized), writeln('-----'),
  sha_hash(Serialized, Hash, [algorithm(sha256), encoding(utf8)]),
  atom_string(HashA, Hash),
  get_base64(HashA, HashE),
  atom_concat('RA', HashE, ArtifactCodeMade).


serialize([], '').

serialize([rdf(S,P,O,G)|Rest], Serialized) :-
  value_to_atom(S, SA),
  value_to_atom(P, PA),
  value_to_atom(O, OA),
  value_to_atom(G, GA),
  serialize(Rest, RestSerialized),
  atomic_list_concat([GA, SA, PA, OA, RestSerialized], '', Serialized).


value_to_atom('', '\n') :-
  !.

value_to_atom(literal(lang(Lang, V)), Out) :-
  !,
  string_lower(Lang, LangLS),
  atom_string(LangL, LangLS),
  escape(V, VE),
  atomic_list_concat(['@', LangL, ' ', VE, '\n'], '', Out).

value_to_atom(literal(type(Type, V)), Out) :-
  !,
  escape(V, VE),
  atomic_list_concat(['^', Type, ' ', VE, '\n'], '', Out).

value_to_atom(literal(V), Out) :-
  !,
  escape(V, VE),
  atomic_list_concat(['^http://www.w3.org/2001/XMLSchema#string ', VE, '\n'], '', Out).

value_to_atom(Uri, Out) :-
  atom_concat(Uri, '\n', Out).


escape(In, Out) :-
  atomic_list_concat(L1, '\\', In),
  atomic_list_concat(L1, '\\\\', Temp),
  atomic_list_concat(L2, '\n', Temp),
  atomic_list_concat(L2, '\\n', Out).
  

