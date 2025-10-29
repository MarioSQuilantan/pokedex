import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

@lazySingleton
class DeleteFavoritePokemonUseCase {
  final PokemonRepository repository;

  DeleteFavoritePokemonUseCase(this.repository);

  TaskEither<DbException, Unit> call(DeleteFavoritePokemonRequest request) => repository.deleteFavoritePokemon(request);
}
