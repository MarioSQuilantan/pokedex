import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:pokedex/features/pokemon/application/use_cases/get_pokemon_list_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/get_pokemon_detail_by_id_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/get_favorite_pokemon_list_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/insert_favorite_pokemon_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/delete_favorite_pokemon_use_case.dart';
import 'package:pokedex/features/pokemon/domain/domain.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/pokemon/data/requests/get_pokemon_list_request.dart';
import 'package:pokedex/features/pokemon/data/requests/get_pokemon_detail_request.dart';
import 'package:pokedex/features/pokemon/data/requests/insert_favorite_pokemon_request.dart';
import 'package:pokedex/features/pokemon/data/requests/delete_favorite_pokemon_request.dart';
import 'package:flutter/material.dart';

class _FakeRepo implements PokemonRepository {
  final List<PokemonEntity> list;
  final PokemonDetailEntity detail;
  final List<PokemonEntity> favorites;

  _FakeRepo({required this.list, required this.detail, required this.favorites});

  @override
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) async {
    favorites.removeWhere((f) => f.id == request.id);
    return unit;
  }

  @override
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) async {
    favorites.add(PokemonEntity(name: request.name, id: request.id, imagePath: request.imagePath));
    return unit;
  }

  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return TaskEither.right(detail);
  }

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(GetPokemonListRequest request) {
    return TaskEither.right(list);
  }

  @override
  Future<List<PokemonEntity>> getFavoritePokemonList() async => favorites;
}

void main() {
  group('Use cases', () {
    final sampleList = [PokemonEntity(name: 'bulbasaur', id: 1, imagePath: 'u')];
    final sampleDetail = PokemonDetailEntity(
      id: 1,
      name: 'bulbasaur',
      height: 1,
      weight: 1,
      imageUrl: 'u',
      background: const Color(0xFF000000),
      types: const [],
      abilities: const [],
      baseExperience: 0,
      stats: const [],
    );
    final favs = <PokemonEntity>[];

    final repo = _FakeRepo(list: sampleList, detail: sampleDetail, favorites: favs);

    test('GetPokemonListUseCase returns list', () async {
      final useCase = GetPokemonListUseCase(repo);
      final result = await useCase(GetPokemonListRequest(offset: 0, limit: 50)).run();
      expect(result.isRight(), true);
    });

    test('GetPokemonDetailUseCase returns detail', () async {
      final useCase = GetPokemonDetailUseCase(repo);
      final result = await useCase(GetPokemonDetailByIdRequest(id: 1)).run();
      expect(result.isRight(), true);
    });

    test('GetFavoritePokemonListUseCase returns favorites', () async {
      final useCase = GetFavoritePokemonListUseCase(repo);
      final result = await useCase();
      expect(result, favs);
    });

    test('Insert/Delete favorite use cases modify favorites', () async {
      final insert = InsertFavoritePokemonUseCase(repo);
      final delete = DeleteFavoritePokemonUseCase(repo);

      await insert(InsertFavoritePokemonRequest(id: 10, name: 'caterpie', imagePath: 'u'));
      expect(favs.length, 1);

      await delete(DeleteFavoritePokemonRequest(id: 10));
      expect(favs.length, 0);
    });
  });
}
