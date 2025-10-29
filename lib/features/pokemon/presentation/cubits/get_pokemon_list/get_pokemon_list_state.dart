part of 'get_pokemon_list_cubit.dart';

class GetPokemonListState extends Equatable {
  const GetPokemonListState({this.status, this.errorMessage = '', this.pokemonList = const []});

  final NetworkStatusEnum? status;
  final String errorMessage;
  final List<PokemonEntity> pokemonList;

  GetPokemonListState copyWith({NetworkStatusEnum? status, String? errorMessage, List<PokemonEntity>? pokemonList}) =>
      GetPokemonListState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        pokemonList: pokemonList ?? this.pokemonList,
      );

  @override
  List<Object?> get props => [status, errorMessage, pokemonList];
}
