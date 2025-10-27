part of 'get_pokemon_list_bloc.dart';

sealed class GetPokemonListEvent extends Equatable {
  const GetPokemonListEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonList extends GetPokemonListEvent {
  const GetPokemonList();
}

class LoadMore extends GetPokemonListEvent {
  const LoadMore();
}
