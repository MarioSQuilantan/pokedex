import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

@lazySingleton
class GetPokemonDetailUseCase {
  final PokemonRepository repository;

  GetPokemonDetailUseCase(this.repository);

  TaskEither<NetworkException, PokemonDetailEntity> call(GetPokemonDetailByIdRequest request) =>
      repository.getPokemonDetailById(request);
}
