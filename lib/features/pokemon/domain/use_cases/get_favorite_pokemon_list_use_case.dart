import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../domain.dart';

@lazySingleton
class GetFavoritePokemonListUseCase {
  final PokemonRepository repository;

  GetFavoritePokemonListUseCase(this.repository);

  TaskEither<DbException, List<PokemonEntity>> call() => repository.getFavoritePokemonList();
}
