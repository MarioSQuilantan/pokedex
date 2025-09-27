import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/features.dart';

class _FakeRepo implements PokemonRepository {
  final List<PokemonEntity> list;

  _FakeRepo({required this.list});

  @override
  Future<Unit> deleteFavoritePokemon(DeleteFavoritePokemonRequest request) async => unit;

  @override
  Future<Unit> insertFavoritePokemon(InsertFavoritePokemonRequest request) async => unit;

  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    throw UnimplementedError();
  }

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(GetPokemonListRequest request) {
    return TaskEither.right(list);
  }

  @override
  Future<List<PokemonEntity>> getFavoritePokemonList() async => [];
}

void main() {
  group('PokemonListCubit', () {
    late PokemonListCubit cubit;
    final sampleEntities = [
      PokemonEntity(name: 'one', id: 1, imagePath: 'u1'),
      PokemonEntity(name: 'two', id: 2, imagePath: 'u2'),
    ];

    setUp(() {
      final repo = _FakeRepo(list: sampleEntities);
      final getList = GetPokemonListUseCase(repo);
      cubit = PokemonListCubit(getList);
    });

    test('initial state is PokemonItemsInitial', () {
      expect(cubit.state, isA<PokemonItemsInitial>());
    });

    test('onGetPokemonList emits Loading then PokemonItemsLoaded', () async {
      final states = <PokemonItemsState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.onGetPokemonList();
      await Future.delayed(Duration.zero);

      expect(states.first, isA<PokemonItemsLoading>());
      expect(states.last, isA<PokemonItemsLoaded>());
      final last = states.last as PokemonItemsLoaded;
      expect(last.items.length, sampleEntities.length);

      await sub.cancel();
    });
  });
}
