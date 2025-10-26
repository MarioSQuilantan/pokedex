import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../features.dart';

part 'get_pokemon_detail_by_id_event.dart';
part 'get_pokemon_detail_by_id_state.dart';

@injectable
class GetPokemonDetailByIdBloc extends Bloc<GetPokemonDetailByIdEvent, GetPokemonDetailByIdState> {
  final GetPokemonDetailUseCase getPokemonDetailUseCase;

  GetPokemonDetailByIdBloc(this.getPokemonDetailUseCase) : super(GetPokemonDetailByIdInitial()) {
    on<GetPokemonDetailById>(_getPokemonDetailById);
  }

  Future<void> _getPokemonDetailById(GetPokemonDetailById event, Emitter<GetPokemonDetailByIdState> emit) async {
    emit(GetPokemonDetailByIdLoading());

    final response = await getPokemonDetailUseCase(GetPokemonDetailByIdRequest(id: event.id)).run();

    response.match(
      (err) => emit(GetPokemonDetailByIdError(message: err.toString())),
      (values) => emit(GetPokemonDetailByIdSuccess()),
    );
  }
}
