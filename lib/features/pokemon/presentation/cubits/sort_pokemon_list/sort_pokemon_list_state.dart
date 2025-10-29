part of 'sort_pokemon_list_cubit.dart';

enum SortOptions { nameAsc, nameDesc, byId }

class SortPokemonListState extends Equatable {
  const SortPokemonListState({this.sortedPokemonList = const [], this.sortOption = SortOptions.byId});

  final List<PokemonEntity> sortedPokemonList;
  final SortOptions sortOption;

  SortPokemonListState copyWith({List<PokemonEntity>? sortedPokemonList, SortOptions? sortOption}) =>
      SortPokemonListState(
        sortedPokemonList: sortedPokemonList ?? this.sortedPokemonList,
        sortOption: sortOption ?? this.sortOption,
      );

  @override
  List<Object?> get props => [sortedPokemonList, sortOption];
}
