import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

@LazySingleton(as: PokemonRepository)
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiDataSource api;
  final PokemonDatabaseDataSource database;

  final _pokemonListCtrl = StreamController<List<PokemonEntity>>.broadcast();

  PokemonRepositoryImpl(this.api, this.database);

  // Expose the stream as the single source of truth for the list
  @override
  Stream<List<PokemonEntity>> get pokemonListStream => _pokemonListCtrl.stream;

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(GetPokemonListRequest request) =>
      api.getPokemonList(request).map((listOfModels) {
        final list = listOfModels.map((model) => model.toEntity()).toList();
        // Emit latest list to subscribers
        try {
          _pokemonListCtrl.add(list);
        } catch (_) {}
        return list;
      });

  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request) =>
      api.getPokemonDetailById(request).map((model) => model.toEntity());

  @override
  TaskEither<DbException, Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) =>
      database.deleteFavoritePokemon(request);

  @override
  TaskEither<DbException, List<PokemonEntity>> getFavoritePokemonList() =>
      database.getFavoritePokemonList().map((listOfModels) => listOfModels.toEntityList());

  @override
  TaskEither<DbException, Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) =>
      database.insertFavoritePokemon(request).map((_) => unit);

  // @override
  // stream getter implemented above

  void dispose() {
    if (!_pokemonListCtrl.isClosed) {
      _pokemonListCtrl.close();
    }
  }
}
