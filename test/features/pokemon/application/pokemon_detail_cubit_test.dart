import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokedex/features/pokemon/application/application.dart';
import 'package:pokedex/features/pokemon/domain/domain.dart';
import 'package:pokedex/features/pokemon/data/requests/get_pokemon_detail_request.dart';
import 'package:pokedex/core/resources/network_exception.dart';
import 'package:flutter/material.dart';

class _SuccessRepo implements PokemonRepository {
  final PokemonDetailEntity detail;
  _SuccessRepo(this.detail);

  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return TaskEither.right(detail);
  }

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(request) => TaskEither.right([]);

  @override
  Future<List<PokemonEntity>> getFavoritePokemonList() async => [];

  @override
  Future<Unit> insertFavoritePokemon(request) async => unit;

  @override
  Future<Unit> deleteFavoritePokemon(request) async => unit;
}

class _FailureRepo implements PokemonRepository {
  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return TaskEither.left(NetworkException(message: 'not found'));
  }

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(request) => TaskEither.right([]);

  @override
  Future<List<PokemonEntity>> getFavoritePokemonList() async => [];

  @override
  Future<Unit> insertFavoritePokemon(request) async => unit;

  @override
  Future<Unit> deleteFavoritePokemon(request) async => unit;
}

void main() {
  group('PokemonDetailCubit', () {
    test('initial state is PokemonDetailInitial', () {
      final repo = _SuccessRepo(
        const PokemonDetailEntity(
          id: 1,
          name: 'one',
          height: 1,
          weight: 1,
          imageUrl: 'u',
          background: Color(0xFF000000),
          types: [],
          abilities: [],
          baseExperience: 0,
          stats: [],
        ),
      );
      final useCase = GetPokemonDetailUseCase(repo);
      final cubit = PokemonDetailCubit(useCase);
      expect(cubit.state, isA<PokemonDetailInitial>());
    });

    test('onGetPokemonDetailById emits Loading then Loaded on success', () async {
      final detail = const PokemonDetailEntity(
        id: 42,
        name: 'pikachu',
        height: 4,
        weight: 6,
        imageUrl: 'u',
        background: Color(0xFFFFFFFF),
        types: [],
        abilities: [],
        baseExperience: 0,
        stats: [],
      );
      final repo = _SuccessRepo(detail);
      final useCase = GetPokemonDetailUseCase(repo);
      final cubit = PokemonDetailCubit(useCase);

      final states = <PokemonDetailState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.onGetPokemonDetailById(id: 42);
      await Future.delayed(Duration.zero);

      expect(states.first, isA<PokemonDetailLoading>());
      expect(states.last, isA<PokemonDetailLoaded>());
      final last = states.last as PokemonDetailLoaded;
      expect(last.pokemonDetail.id, detail.id);

      await sub.cancel();
    });

    test('onGetPokemonDetailById emits Failure on repository error', () async {
      final repo = _FailureRepo();
      final useCase = GetPokemonDetailUseCase(repo);
      final cubit = PokemonDetailCubit(useCase);

      final states = <PokemonDetailState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.onGetPokemonDetailById(id: 7);
      await Future.delayed(Duration.zero);

      expect(states.first, isA<PokemonDetailLoading>());
      expect(states.last, isA<PokemonDetailFailure>());
      final last = states.last as PokemonDetailFailure;
      expect(last.message, contains('not found'));

      await sub.cancel();
    });
  });
}
