part of 'sort_pokemon_list_bloc.dart';

enum SortOption { none, nameAsc, nameDesc, byId }

sealed class SortPokemonListState extends Equatable {
  const SortPokemonListState();

  @override
  List<Object> get props => [];
}

class SortPokemonListInitial extends SortPokemonListState {
  const SortPokemonListInitial();
}

class SortPokemonListOption extends SortPokemonListState {
  final SortOption option;
  const SortPokemonListOption(this.option);

  @override
  List<Object> get props => [option];
}
