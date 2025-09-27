import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/features.dart';

class _FakeNetworkService implements NetworkService {
  final Map<String, dynamic> response;
  _FakeNetworkService(this.response);

  @override
  TaskEither<NetworkException, T> get<T>(String path, {Map<String, dynamic>? queryParameters, bool useToken = true}) {
    return TaskEither.right(response as T);
  }

  @override
  TaskEither<NetworkException, T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) {
    throw UnimplementedError();
  }

  @override
  TaskEither<NetworkException, T> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) {
    throw UnimplementedError();
  }

  @override
  TaskEither<NetworkException, T> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool useToken = true,
  }) {
    throw UnimplementedError();
  }
}

class _FakeDatabaseService implements DatabaseService {
  final List<Map<String, dynamic>> store;
  _FakeDatabaseService(this.store);

  @override
  Future<dynamic> deleteById(String table, int id) async {
    store.removeWhere((m) => m['id'] == id);
    return {};
  }

  @override
  Future<dynamic> get(String table) async {
    return store;
  }

  @override
  Future<dynamic> insert(String table, Map<String, dynamic> data) async {
    store.add(data);
    return {};
  }
}

void main() {
  group('PokemonRemoteDataSourceImpl', () {
    test('parses list response into models', () async {
      final fakeResponse = {
        'results': [
          {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
          {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
        ],
      };

      final network = _FakeNetworkService(fakeResponse);
      final db = _FakeDatabaseService([]);
      final ds = PokemonRemoteDataSourceImpl(network, db);

      final result = await ds.getPokemonList(GetPokemonListRequest(offset: 0, limit: 50)).run();

      expect(result.isRight(), true);
      result.fold((l) => fail('expected right'), (r) {
        expect(r.length, 2);
        expect(r[0].name, 'bulbasaur');
        expect(r[0].url, 'https://pokeapi.co/api/v2/pokemon/1/');
      });
    });

    test('parses detail response into model', () async {
      final fakeResponse = {
        'id': 25,
        'name': 'pikachu',
        'sprites': {
          'other': {
            'official-artwork': {'front_default': 'https://image.png'},
          },
        },
      };

      final network = _FakeNetworkService(fakeResponse);
      final db = _FakeDatabaseService([]);
      final ds = PokemonRemoteDataSourceImpl(network, db);

      final result = await ds.getPokemonDetailById(GetPokemonDetailByIdRequest(id: 25)).run();
      expect(result.isRight(), true);
      result.fold((l) => fail('expected right'), (r) {
        expect(r.id, 25);
        expect(r.name, 'pikachu');
      });
    });

    test('database favorites operations work', () async {
      final network = _FakeNetworkService({'results': []});
      final dbStore = <Map<String, dynamic>>[];
      final db = _FakeDatabaseService(dbStore);
      final ds = PokemonRemoteDataSourceImpl(network, db);

      await ds.insertFavoritePokemon(InsertFavoritePokemonRequest(id: 10, name: 'caterpie', imagePath: 'url'));
      var list = await ds.getFavoritePokemonList();
      expect(list.length, 1);
      expect(list[0].id, 10);

      await ds.deleteFavoritePokemon(DeleteFavoritePokemonRequest(id: 10));
      list = await ds.getFavoritePokemonList();
      expect(list.length, 0);
    });
  });
}
