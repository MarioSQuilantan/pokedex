part of 'get_pokemon_detail_by_id_bloc.dart';

sealed class GetPokemonDetailByIdEvent extends Equatable {
  const GetPokemonDetailByIdEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonDetailById extends GetPokemonDetailByIdEvent {
  final int id;

  const GetPokemonDetailById(this.id);
}
