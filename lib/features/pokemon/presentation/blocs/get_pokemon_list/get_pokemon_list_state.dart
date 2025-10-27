part of 'get_pokemon_list_bloc.dart';

sealed class GetPokemonListState extends Equatable {
  const GetPokemonListState();

  @override
  List<Object> get props => [];
}

final class GetPokemonListInitial extends GetPokemonListState {}

final class GetPokemonListLoading extends GetPokemonListState {}

final class GetPokemonListSuccess extends GetPokemonListState {
  final List<PokemonEntity> pokemonList;

  const GetPokemonListSuccess({required this.pokemonList});

  @override
  List<Object> get props => [pokemonList];
}

final class GetPokemonListError extends GetPokemonListState {
  final String message;

  const GetPokemonListError({required this.message});

  @override
  List<Object> get props => [message];
}
