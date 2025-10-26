import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

abstract interface class PokemonRepository {
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(GetPokemonListRequest request);
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request);
  TaskEither<DbException, List<PokemonEntity>> getFavoritePokemonList();
  TaskEither<DbException, Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request);
  TaskEither<DbException, Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request);
}
