part of 'filter_pokemon_list_bloc.dart';

sealed class FilterPokemonListEvent extends Equatable {
  const FilterPokemonListEvent();

  @override
  List<Object> get props => [];
}

class FilterByName extends FilterPokemonListEvent {
  final String query;
  final List<PokemonEntity> baseList;

  const FilterByName({required this.query, required this.baseList});

  @override
  List<Object> get props => [query, baseList];
}
