import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../data.dart';

@LazySingleton(as: PokemonDatabaseDataSource)
class PokemonDatabaseRemoteDataSourceImpl implements PokemonDatabaseDataSource {
  final DatabaseService database;
  PokemonDatabaseRemoteDataSourceImpl(this.database);

  @override
  TaskEither<DbException, Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) =>
      database.deleteById(DataBaseTableEnum.favoritePokemon.name, request.id).map((_) => unit);

  @override
  TaskEither<DbException, List<PokemonListDataBaseModel>> getFavoritePokemonList() =>
      database.get(DataBaseTableEnum.favoritePokemon.name).map((data) => PokemonListDataBaseModel.fromJsonList(data));

  @override
  TaskEither<DbException, Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) =>
      database.insert(DataBaseTableEnum.favoritePokemon.name, request.toJson()).map((_) => unit);
}
