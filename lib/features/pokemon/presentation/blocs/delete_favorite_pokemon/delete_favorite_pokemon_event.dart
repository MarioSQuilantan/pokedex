part of 'delete_favorite_pokemon_bloc.dart';

sealed class DeleteFavoritePokemonEvent extends Equatable {
  const DeleteFavoritePokemonEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoritePokemon extends DeleteFavoritePokemonEvent {
  final int id;

  const DeleteFavoritePokemon(this.id);
}
