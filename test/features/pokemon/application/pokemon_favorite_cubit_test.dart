import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/features.dart';

class _FakeRepo implements PokemonRepository {
  final List<PokemonEntity> favorites = [];

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
  Future<List<PokemonEntity>> getFavoritePokemonList() async => List<PokemonEntity>.from(favorites);

  @override
  TaskEither<NetworkException, PokemonDetailEntity> getPokemonDetailById(request) =>
      TaskEither.left(NetworkException(message: 'not implemented'));

  @override
  TaskEither<NetworkException, List<PokemonEntity>> getPokemonList(request) => TaskEither.right([]);
}

void main() {
  group('PokemonFavoriteCubit', () {
    late PokemonFavoriteCubit cubit;
    late _FakeRepo repo;

    setUp(() {
      repo = _FakeRepo();
      final getFav = GetFavoritePokemonListUseCase(repo);
      final insertFav = InsertFavoritePokemonUseCase(repo);
      final deleteFav = DeleteFavoritePokemonUseCase(repo);
      cubit = PokemonFavoriteCubit(getFav, insertFav, deleteFav);
    });

    test('initial state is PokemonFavoriteInitial', () {
      expect(cubit.state, isA<PokemonFavoriteInitial>());
    });

    test('addPokemonToFavorites emits loaded state and marks favorite', () async {
      final pokemon = PokemonEntity(name: 'one', id: 1, imagePath: 'u1');
      final states = <PokemonFavoriteState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.addPokemonToFavorites(pokemon);
      await Future.delayed(Duration.zero);

      expect(states.last, isA<PokemonFavoriteLoaded>());
      expect(cubit.isPokemonFavorite(1), true);

      await sub.cancel();
    });

    test('removePokemonFromFavorites removes favorite and emits', () async {
      final pokemon = PokemonEntity(name: 'one', id: 2, imagePath: 'u2');
      await cubit.addPokemonToFavorites(pokemon);
      expect(cubit.isPokemonFavorite(2), true);

      final states = <PokemonFavoriteState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.removePokemonFromFavorites(2);
      await Future.delayed(Duration.zero);

      expect(cubit.isPokemonFavorite(2), false);
      expect(states.last, isA<PokemonFavoriteLoaded>());

      await sub.cancel();
    });
  });
}
