import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

@lazySingleton
class DeleteFavoritePokemonUseCase {
  final PokemonRepository repository;

  DeleteFavoritePokemonUseCase(this.repository);

  Future<Unit> call(DeleteFavoritePokemonRequest request) async => await repository.deleteFavoritePokemon(request);
}
