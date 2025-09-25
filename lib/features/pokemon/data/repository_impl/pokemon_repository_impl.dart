import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

@LazySingleton(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDataSource dataSource;

  PokemonRepositoryImpl(this.dataSource);

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(GetPokemonListRequest request) =>
      dataSource.getPokemonList(request).map((listOfModels) => listOfModels.map((model) => model.toEntity()).toList());

  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return dataSource.getPokemonDetailById(request).map((model) => model.toEntity());
  }

  @override
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) async =>
      await dataSource.deleteFavoritePokemon(request);

  @override
  Future<List<PokemonEntity>> getFavoritePokemonList() async {
    final response = await dataSource.getFavoritePokemonList();
    return response.toEntityList();
  }

  @override
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) async =>
      await dataSource.insertFavoritePokemon(request);
}
