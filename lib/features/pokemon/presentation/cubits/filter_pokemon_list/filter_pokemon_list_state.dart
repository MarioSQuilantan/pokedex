part of 'filter_pokemon_list_cubit.dart';

class FilterPokemonListState extends Equatable {
  const FilterPokemonListState({this.filteredList = const []});

  final List<PokemonEntity> filteredList;

  FilterPokemonListState copyWith({List<PokemonEntity>? filteredList}) =>
      FilterPokemonListState(filteredList: filteredList ?? this.filteredList);

  @override
  List<Object?> get props => [filteredList];
}
