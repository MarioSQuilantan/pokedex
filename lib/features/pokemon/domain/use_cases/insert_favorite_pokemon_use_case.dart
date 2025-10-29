import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

@lazySingleton
class InsertFavoritePokemonUseCase {
  final PokemonRepository repository;

  InsertFavoritePokemonUseCase(this.repository);

  TaskEither<DbException, Unit> call(InsertFavoritePokemonRequest request) => repository.insertFavoritePokemon(request);
}
