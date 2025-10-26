part of 'get_favorite_pokemon_list_bloc.dart';

sealed class GetFavoritePokemonListEvent extends Equatable {
  const GetFavoritePokemonListEvent();

  @override
  List<Object> get props => [];
}

class GetFavoritePokemonList extends GetFavoritePokemonListEvent {
  const GetFavoritePokemonList();
}
