part of 'sort_pokemon_list_cubit.dart';

enum SortOptions { nameAsc, nameDesc, byId }

class SortPokemonListState extends Equatable {
  const SortPokemonListState({this.sortedPokemonList = const []});

  final List<PokemonEntity> sortedPokemonList;

  SortPokemonListState copyWith({List<PokemonEntity>? sortedPokemonList}) =>
      SortPokemonListState(sortedPokemonList: sortedPokemonList ?? this.sortedPokemonList);

  @override
  List<Object?> get props => [sortedPokemonList];
}
