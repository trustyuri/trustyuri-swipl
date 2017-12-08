:- use_module(file_module).

trustyuri_module('FA').

has_correct_hash('FA', Resource) :-
  has_correct_hash_fa(Resource).
