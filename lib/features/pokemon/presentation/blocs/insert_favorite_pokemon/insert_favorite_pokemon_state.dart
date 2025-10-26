part of 'insert_favorite_pokemon_bloc.dart';

sealed class InsertFavoritePokemonState extends Equatable {
  const InsertFavoritePokemonState();

  @override
  List<Object> get props => [];
}

final class InsertFavoritePokemonInitial extends InsertFavoritePokemonState {}

final class InsertFavoritePokemonLoading extends InsertFavoritePokemonState {}

final class InsertFavoritePokemonSuccess extends InsertFavoritePokemonState {}

final class InsertFavoritePokemonError extends InsertFavoritePokemonState {
  final String message;

  const InsertFavoritePokemonError({required this.message});
}
