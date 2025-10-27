part of 'sort_pokemon_list_bloc.dart';

sealed class SortPokemonListEvent extends Equatable {
  const SortPokemonListEvent();

  @override
  List<Object> get props => [];
}

class SortByNameAsc extends SortPokemonListEvent {
  const SortByNameAsc();
}

class SortByNameDesc extends SortPokemonListEvent {
  const SortByNameDesc();
}

class SortById extends SortPokemonListEvent {
  const SortById();
}

class SortNone extends SortPokemonListEvent {
  const SortNone();
}
