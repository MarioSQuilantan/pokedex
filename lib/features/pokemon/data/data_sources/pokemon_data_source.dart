import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../data.dart';

abstract interface class PokemonDataSource {
  TaskEither<NetworkException, List<PokemonListApiModel>> getPokemonList(GetPokemonListRequest request);
  TaskEither<NetworkException, PokemonDetailApiModel> getPokemonDetailById(GetPokemonDetailByIdRequest request);
  Future<List<PokemonListDataBaseModel>> getFavoritePokemonList();
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request);
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request);
}
