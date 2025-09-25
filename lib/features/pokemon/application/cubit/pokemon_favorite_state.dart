import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class PokemonFavoriteState extends Equatable {
  const PokemonFavoriteState();

  @override
  List<Object> get props => [];
}

class PokemonFavoriteInitial extends PokemonFavoriteState {}

class PokemonFavoriteLoading extends PokemonFavoriteState {}

class PokemonFavoriteLoaded extends PokemonFavoriteState {
  final List<PokemonEntity> favoriteList;

  const PokemonFavoriteLoaded(this.favoriteList);

  @override
  List<Object> get props => [favoriteList];
}

class PokemonFavoriteFailure extends PokemonFavoriteState {
  final String message;

  const PokemonFavoriteFailure(this.message);

  @override
  List<Object> get props => [message];
}
