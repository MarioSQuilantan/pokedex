import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';

@lazySingleton
class GetFavoritePokemonListUseCase {
  final PokemonRepository repository;

  GetFavoritePokemonListUseCase(this.repository);

  Future<List<PokemonEntity>> call() async => await repository.getFavoritePokemonList();
}
