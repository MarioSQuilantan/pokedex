part of 'filter_pokemon_list_bloc.dart';

sealed class FilterPokemonListState extends Equatable {
  const FilterPokemonListState();

  @override
  List<Object> get props => [];
}

final class FilterPokemonListInitial extends FilterPokemonListState {}

class FilterPokemonListFiltered extends FilterPokemonListState {
  final List<PokemonEntity> filteredList;
  const FilterPokemonListFiltered(this.filteredList);

  @override
  List<Object> get props => [filteredList];
}
