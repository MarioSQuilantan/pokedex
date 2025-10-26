import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

@lazySingleton
class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  TaskEither<NetworkException, List<PokemonEntity>> call(GetPokemonListRequest request) =>
      repository.getPokemonList(request);
}
