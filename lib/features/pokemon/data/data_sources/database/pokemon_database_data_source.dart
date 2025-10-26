import 'package:fpdart/fpdart.dart';

import '../../../../../core/core.dart';
import '../../data.dart';

abstract interface class PokemonDatabaseDataSource {
  TaskEither<DbException, List<PokemonListDataBaseModel>> getFavoritePokemonList();
  TaskEither<DbException, Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request);
  TaskEither<DbException, Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request);
}
