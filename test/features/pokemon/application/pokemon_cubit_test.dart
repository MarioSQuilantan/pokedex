import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokedex/features/pokemon/application/cubit/pokemon_cubit.dart';
import 'package:pokedex/features/pokemon/application/use_cases/get_pokemon_list_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/get_pokemon_detail_by_id_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/get_favorite_pokemon_list_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/insert_favorite_pokemon_use_case.dart';
import 'package:pokedex/features/pokemon/application/use_cases/delete_favorite_pokemon_use_case.dart';
import 'package:pokedex/features/pokemon/data/requests/get_pokemon_list_request.dart';
import 'package:pokedex/features/pokemon/data/requests/get_pokemon_detail_request.dart';
import 'package:pokedex/features/pokemon/data/requests/insert_favorite_pokemon_request.dart';
import 'package:pokedex/features/pokemon/data/requests/delete_favorite_pokemon_request.dart';
import 'package:pokedex/core/resources/network_exception.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon/domain/domain.dart';

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
  group('PokemonCubit', () {
    late PokemonCubit cubit;
    final sampleEntities = [
      PokemonEntity(name: 'one', id: 1, imagePath: 'u1'),
      PokemonEntity(name: 'two', id: 2, imagePath: 'u2'),
    ];
    final detail = PokemonDetailEntity(
      id: 1,
      name: 'one',
      height: 1,
      weight: 1,
      imageUrl: 'u',
      background: const Color(0xFF000000),
      types: const [],
      abilities: const [],
      baseExperience: 0,
      stats: const [],
    );
    late _FakeRepo repo;

    setUp(() {
      repo = _FakeRepo(list: sampleEntities, detail: detail, favorites: []);
      final getList = GetPokemonListUseCase(repo);
      final getDetail = GetPokemonDetailUseCase(repo);
      final getFav = GetFavoritePokemonListUseCase(repo);
      final insertFav = InsertFavoritePokemonUseCase(repo);
      final deleteFav = DeleteFavoritePokemonUseCase(repo);
      cubit = PokemonCubit(getList, getDetail, getFav, insertFav, deleteFav);
    });

    test('initial state is PokemonInitial', () {
      expect(cubit.state, isA<PokemonInitial>());
    });

    test('onGetPokemonList emits Loading then PokemonListLoaded', () async {
      final states = <PokemonState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.onGetPokemonList();

      // Wait a microtask for emissions
      await Future.delayed(Duration.zero);
      expect(states.length >= 2, true);
      expect(states.first, isA<PokemonLoading>());
      expect(states.last, isA<PokemonListLoaded>());
      final last = states.last as PokemonListLoaded;
      expect(last.pokemonList.length, sampleEntities.length);

      await sub.cancel();
    });

    test('loadFavoritesSilently populates favorites without emitting', () async {
      expect(cubit.hasLoadedFavorites, false);
      // prepare repo with a favorite so loadFavoritesSilently actually populates
      repo.favorites.add(PokemonEntity(name: 'fav', id: 99, imagePath: 'u'));
      await cubit.loadFavoritesSilently();
      expect(cubit.hasLoadedFavorites, true);
    });

    test('onAddPokemonToFavorites updates favorites and re-emits list when in list state', () async {
      // prepare state by loading list
      await cubit.onGetPokemonList();
      expect(cubit.state, isA<PokemonListLoaded>());

      final states = <PokemonState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.onGetPokemonList();
      await cubit.loadFavoritesSilently();
      await cubit.onAddPokemonToFavorites(id: 1);
      await Future.delayed(Duration(milliseconds: 10));

      expect(states.any((s) => s is PokemonListLoaded), true);
      expect(cubit.isPokemonFavorite(1), true);

      await sub.cancel();
    });

    test('onRemovePokemonFromFavorites removes favorite and re-emits when in list state', () async {
      // prepare list and add favorite
      await cubit.onGetPokemonList();
      await cubit.onAddPokemonToFavorites(id: 2);
      expect(cubit.isPokemonFavorite(2), true);

      final states = <PokemonState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.onGetPokemonList();
      await cubit.onAddPokemonToFavorites(id: 2);
      await cubit.loadFavoritesSilently();
      await cubit.onRemovePokemonFromFavorites(pokemonId: 2);
      await Future.delayed(Duration(milliseconds: 10));

      expect(cubit.isPokemonFavorite(2), false);
      expect(states.any((s) => s is PokemonListLoaded), true);

      await sub.cancel();
    });
  });
}
