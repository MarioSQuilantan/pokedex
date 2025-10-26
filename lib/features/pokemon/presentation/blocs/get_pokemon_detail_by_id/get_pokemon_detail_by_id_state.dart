part of 'get_pokemon_detail_by_id_bloc.dart';

sealed class GetPokemonDetailByIdState extends Equatable {
  const GetPokemonDetailByIdState();

  @override
  List<Object> get props => [];
}

final class GetPokemonDetailByIdInitial extends GetPokemonDetailByIdState {}

final class GetPokemonDetailByIdLoading extends GetPokemonDetailByIdState {}

final class GetPokemonDetailByIdSuccess extends GetPokemonDetailByIdState {}

final class GetPokemonDetailByIdError extends GetPokemonDetailByIdState {
  final String message;

  const GetPokemonDetailByIdError({required this.message});
}
