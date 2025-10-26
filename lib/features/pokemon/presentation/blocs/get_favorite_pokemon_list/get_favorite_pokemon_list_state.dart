part of 'get_favorite_pokemon_list_bloc.dart';

sealed class GetFavoritePokemonListState extends Equatable {
  const GetFavoritePokemonListState();

  @override
  List<Object> get props => [];
}

final class GetFavoritePokemonListInitial extends GetFavoritePokemonListState {}

final class GetFavoritePokemonListLoading extends GetFavoritePokemonListState {}

final class GetFavoritePokemonListSuccess extends GetFavoritePokemonListState {}

final class GetFavoritePokemonListError extends GetFavoritePokemonListState {
  final String message;

  const GetFavoritePokemonListError({required this.message});
}
