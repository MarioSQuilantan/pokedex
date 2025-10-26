part of 'delete_favorite_pokemon_bloc.dart';

sealed class DeleteFavoritePokemonState extends Equatable {
  const DeleteFavoritePokemonState();

  @override
  List<Object> get props => [];
}

final class DeleteFavoritePokemonInitial extends DeleteFavoritePokemonState {}

final class DeleteFavoritePokemonSuccess extends DeleteFavoritePokemonState {}

final class DeleteFavoritePokemonError extends DeleteFavoritePokemonState {
  final String message;

  const DeleteFavoritePokemonError({required this.message});
}
