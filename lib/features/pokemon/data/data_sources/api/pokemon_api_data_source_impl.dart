import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../data.dart';

@LazySingleton(as: PokemonApiDataSource)
class PokemonApiRemoteDataSourceImpl implements PokemonApiDataSource {
  final NetworkService network;

  PokemonApiRemoteDataSourceImpl(this.network);

  @override
  TaskEither<NetworkException, List<PokemonListApiModel>> getPokemonList(GetPokemonListRequest request) {
    return network
        .get<Map<String, dynamic>>(
          UrlPathsEnum.getPokemonList.path,
          queryParameters: {'offset': request.offset, 'limit': request.limit},
        )
        .map((data) {
          final results = data['results'] as List<dynamic>;
          return PokemonListApiModel.fromJsonList(results);
        });
  }

  @override
  TaskEither<NetworkException, PokemonDetailApiModel> getPokemonDetailById(GetPokemonDetailByIdRequest request) {
    return network.get<Map<String, dynamic>>('${UrlPathsEnum.getPokemonDetailById.path}${request.id}').map((data) {
      return PokemonDetailApiModel.fromJson(data);
    });
  }
}
