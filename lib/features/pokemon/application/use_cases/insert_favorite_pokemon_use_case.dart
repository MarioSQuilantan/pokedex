import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

@lazySingleton
class InsertFavoritePokemonUseCase {
  final PokemonRepository repository;

  InsertFavoritePokemonUseCase(this.repository);

  Future<Unit> call(InsertFavoritePokemonRequest request) async => await repository.insertFavoritePokemon(request);
}
