part of 'pokemon_detail_cubit.dart';

abstract class PokemonDetailState {}

class PokemonDetailInitial extends PokemonDetailState {}

class PokemonDetailLoading extends PokemonDetailState {}

class PokemonDetailLoaded extends PokemonDetailState {
  final PokemonDetailEntity pokemonDetail;
  PokemonDetailLoaded(this.pokemonDetail);
}

class PokemonDetailFailure extends PokemonDetailState {
  final String message;
  PokemonDetailFailure(this.message);
}
