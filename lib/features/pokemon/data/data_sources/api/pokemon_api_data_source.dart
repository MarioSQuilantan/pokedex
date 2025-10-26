import 'package:fpdart/fpdart.dart';

import '../../../../../core/core.dart';
import '../../data.dart';

abstract interface class PokemonApiDataSource {
  TaskEither<NetworkException, List<PokemonListApiModel>> getPokemonList(GetPokemonListRequest request);
  TaskEither<NetworkException, PokemonDetailApiModel> getPokemonDetailById(GetPokemonDetailByIdRequest request);
}
