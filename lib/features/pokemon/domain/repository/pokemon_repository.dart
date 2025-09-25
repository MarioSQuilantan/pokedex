import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

abstract interface class PokemonRepository {
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(GetPokemonListRequest request);
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request);
  Future<List<PokemonEntity>> getFavoritePokemonList();
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request);
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request);
}
