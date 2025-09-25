part of 'pokemon_cubit.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonListLoaded extends PokemonState {
  final List<PokemonEntity> pokemonList;
  final bool hasMore;
  final bool isLoadingMore;

  const PokemonListLoaded(this.pokemonList, {this.hasMore = true, this.isLoadingMore = false});

  @override
  List<Object> get props => [pokemonList, hasMore, isLoadingMore];
}

class PokemonDetailLoaded extends PokemonState {
  final PokemonDetailEntity pokemonDetail;

  const PokemonDetailLoaded(this.pokemonDetail);

  @override
  List<Object> get props => [pokemonDetail.id];
}

class PokemonFavoriteListLoaded extends PokemonState {
  final List<PokemonEntity> pokemonFavoriteList;

  const PokemonFavoriteListLoaded(this.pokemonFavoriteList);

  @override
  List<Object> get props => [pokemonFavoriteList];
}

class PokemonFailure extends PokemonState {
  final String message;

  const PokemonFailure(this.message);

  @override
  List<Object> get props => [message];
}
