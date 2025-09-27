import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/features.dart';

class _FakeDataSource implements PokemonDataSource {
  final List<PokemonListApiModel> listResponse;
  final List<PokemonListDataBaseModel> dbResponse;
  final PokemonDetailApiModel detailResponse;

  _FakeDataSource({required this.listResponse, required this.dbResponse, required this.detailResponse});

  @override
  TaskEither<NetworkException, List<PokemonListApiModel>> getPokemonList(GetPokemonListRequest request) {
    return TaskEither.right(listResponse);
  }

  @override
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) async {
    dbResponse.removeWhere((m) => m.id == request.id);
    return unit;
  }

  @override
  TaskEither<NetworkException, PokemonDetailApiModel> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return TaskEither.right(detailResponse);
  }

  @override
  Future<List<PokemonListDataBaseModel>> getFavoritePokemonList() async {
    return dbResponse;
  }

  @override
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) async {
    dbResponse.add(PokemonListDataBaseModel(name: request.name, id: request.id, imagePath: request.imagePath));
    return unit;
  }
}

void main() {
  group('PokemonRepositoryImpl', () {
    test('maps list api models to entities', () async {
      final listApi = [
        PokemonListApiModel(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/'),
        PokemonListApiModel(name: 'ivysaur', url: 'https://pokeapi.co/api/v2/pokemon/2/'),
      ];

      final detailApi = PokemonDetailApiModel.fromJson({'id': 1, 'name': 'bulbasaur'});
      final dbList = <PokemonListDataBaseModel>[];

      final ds = _FakeDataSource(listResponse: listApi, dbResponse: dbList, detailResponse: detailApi);
      final repo = PokemonRepositoryImpl(ds);

      final result = await repo.getPokemonList(GetPokemonListRequest(offset: 0, limit: 50)).run();
      expect(result.isRight(), true);
      result.fold((l) => fail('expected right'), (r) {
        expect(r.length, 2);
        expect(r.first.id, 1);
      });
    });

    test('maps db models to entities for favorites', () async {
      final listApi = <PokemonListApiModel>[];
      final dbList = [PokemonListDataBaseModel(name: 'pikachu', id: 25, imagePath: 'url')];
      final detailApi = PokemonDetailApiModel.fromJson({'id': 25, 'name': 'pikachu'});

      final ds = _FakeDataSource(listResponse: listApi, dbResponse: dbList, detailResponse: detailApi);
      final repo = PokemonRepositoryImpl(ds);

      final favorites = await repo.getFavoritePokemonList();
      expect(favorites.length, 1);
      expect(favorites.first.id, 25);
    });
  });
}
