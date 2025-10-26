part of 'insert_favorite_pokemon_bloc.dart';

sealed class InsertFavoritePokemonEvent extends Equatable {
  const InsertFavoritePokemonEvent();

  @override
  List<Object> get props => [];
}

class InsertFavoritePokemon extends InsertFavoritePokemonEvent {
  final int id;
  final String name;
  final String imagePath;

  const InsertFavoritePokemon(this.id, this.name, this.imagePath);
}
