import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../features.dart';

part 'get_pokemon_list_event.dart';
part 'get_pokemon_list_state.dart';

@injectable
class GetPokemonListBloc extends Bloc<GetPokemonListEvent, GetPokemonListState> {
  final GetPokemonListUseCase getPokemonListUseCase;

  GetPokemonListBloc(this.getPokemonListUseCase) : super(GetPokemonListInitial()) {
    on<GetPokemonList>(_getPokemonList);
  }

  Future<void> _getPokemonList(GetPokemonList event, Emitter<GetPokemonListState> emit) async {
    emit(GetPokemonListLoading());

    final response = await getPokemonListUseCase(GetPokemonListRequest(offset: 10, limit: 100)).run();

    response.match(
      (err) => emit(GetPokemonListError(message: err.toString())),
      (values) => emit(GetPokemonListSuccess()),
    );
  }
}
