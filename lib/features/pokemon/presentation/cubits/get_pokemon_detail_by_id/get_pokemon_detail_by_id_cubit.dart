import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/features.dart';

import '../../../../../core/core.dart';

part 'get_pokemon_detail_by_id_state.dart';

@injectable
class GetPokemonDetailByIdCubit extends Cubit<GetPokemonDetailByIdState> {
  final GetPokemonDetailUseCase getPokemonDetailUseCase;

  GetPokemonDetailByIdCubit(this.getPokemonDetailUseCase) : super(GetPokemonDetailByIdState());

  Future<void> getFavoritePokemonList(int id) async {
    emit(state.copyWith(status: NetworkStatusEnum.isLoading));

    final request = GetPokemonDetailByIdRequest(id: id);

    final response = await getPokemonDetailUseCase(request).run();

    response.match(
      (err) => emit(state.copyWith(status: NetworkStatusEnum.isError, errorMessage: err.message)),
      (pokemonDetail) => emit(state.copyWith(status: NetworkStatusEnum.isSuccess, pokemonDetail: pokemonDetail)),
    );
  }
}
