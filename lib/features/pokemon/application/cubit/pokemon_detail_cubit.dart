import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../application.dart';
import '../../data/requests/get_pokemon_detail_request.dart';
import '../../domain/domain.dart';

part 'pokemon_detail_state.dart';

@lazySingleton
class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetailUseCase _getPokemonDetailUseCase;

  PokemonDetailCubit(this._getPokemonDetailUseCase) : super(PokemonDetailInitial());

  Future<void> onGetPokemonDetailById({required int id}) async {
    emit(PokemonDetailLoading());
    final either = await _getPokemonDetailUseCase(GetPokemonDetailByIdRequest(id: id)).run();
    either.fold((l) => emit(PokemonDetailFailure(l.message)), (r) => emit(PokemonDetailLoaded(r)));
  }
}
