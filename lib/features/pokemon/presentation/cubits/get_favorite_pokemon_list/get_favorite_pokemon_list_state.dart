part of 'get_favorite_pokemon_list_cubit.dart';

class GetFavoritePokemonListState extends Equatable {
  const GetFavoritePokemonListState({this.status, this.favoritePokemonList = const [], this.errorMessage = ''});

  final NetworkStatusEnum? status;
  final List<PokemonEntity> favoritePokemonList;
  final String errorMessage;

  GetFavoritePokemonListState copyWith({
    NetworkStatusEnum? status,
    List<PokemonEntity>? favoritePokemonList,
    String? errorMessage,
  }) => GetFavoritePokemonListState(
    status: status ?? this.status,
    favoritePokemonList: favoritePokemonList ?? this.favoritePokemonList,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, favoritePokemonList, errorMessage];
}
