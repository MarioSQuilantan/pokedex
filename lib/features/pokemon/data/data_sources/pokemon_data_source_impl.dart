import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../data.dart';

@LazySingleton(as: PokemonDataSource)
class PokemonRemoteDataSourceImpl implements PokemonDataSource {
  final NetworkService network;
  final DatabaseService database;
  PokemonRemoteDataSourceImpl(this.network, this.database);

  @override
  TaskEither<NetworkException, List<PokemonListApiModel>> getPokemonList(GetPokemonListRequest request) {
    return network
        .get<Map<String, dynamic>>(
          UrlPathsEnum.getPokemonList.path,
          queryParameters: {'offset': request.offset, 'limit': request.limit},
        )
        .map((data) {
          final results = data['results'] as List<dynamic>;
          return PokemonListApiModel.fromJsonList(results);
        });
  }

  @override
  TaskEither<NetworkException, PokemonDetailApiModel> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return network.get<Map<String, dynamic>>('${UrlPathsEnum.getPokemonDetailById.path}${request.id}').map((data) {
      return PokemonDetailApiModel.fromJson(data);
    });
  }

  @override
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) async {
    await database.deleteById(DataBaseTableEnum.favoritePokemon.name, request.id);
    return unit;
  }

  @override
  Future<List<PokemonListDataBaseModel>> getFavoritePokemonList() async {
    final response = await database.get(DataBaseTableEnum.favoritePokemon.name);
    return PokemonListDataBaseModel.fromJsonList(response);
  }

  @override
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) async {
    await database.insert(DataBaseTableEnum.favoritePokemon.name, request.toJson());
    return unit;
  }
}
