part of 'get_pokemon_detail_by_id_cubit.dart';

class GetPokemonDetailByIdState extends Equatable {
  const GetPokemonDetailByIdState({this.status, this.pokemonDetail, this.errorMessage = ''});

  final NetworkStatusEnum? status;
  final PokemonDetailEntity? pokemonDetail;
  final String errorMessage;

  GetPokemonDetailByIdState copyWith({
    NetworkStatusEnum? status,
    PokemonDetailEntity? pokemonDetail,
    String? errorMessage,
  }) => GetPokemonDetailByIdState(
    status: status ?? this.status,
    pokemonDetail: pokemonDetail ?? this.pokemonDetail,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, pokemonDetail, errorMessage];
}
