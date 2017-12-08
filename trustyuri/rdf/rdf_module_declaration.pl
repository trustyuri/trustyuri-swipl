:- use_module(rdf_module).

trustyuri_module('RA').

has_correct_hash('RA', Resource) :-
  has_correct_hash_ra(Resource).
