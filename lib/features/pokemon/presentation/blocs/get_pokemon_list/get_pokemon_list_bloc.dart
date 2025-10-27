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
    on<LoadMore>(_loadMore);
  }

  Future<void> _getPokemonList(GetPokemonList event, Emitter<GetPokemonListState> emit) async {
    emit(GetPokemonListLoading());

    final response = await getPokemonListUseCase(GetPokemonListRequest(offset: 0, limit: 50)).run();

    response.match(
      (err) => emit(GetPokemonListError(message: err.toString())),
      (values) => emit(GetPokemonListSuccess(pokemonList: values)),
    );
  }

  Future<void> _loadMore(LoadMore event, Emitter<GetPokemonListState> emit) async {
    final List<PokemonEntity> currentList = state is GetPokemonListSuccess
        ? (state as GetPokemonListSuccess).pokemonList
        : [];

    emit(GetPokemonListSuccess(pokemonList: currentList));

    final response = await getPokemonListUseCase(GetPokemonListRequest(offset: currentList.length, limit: 50)).run();

    response.match((err) => emit(GetPokemonListError(message: err.toString())), (values) {
      final combined = [...currentList, ...values];
      emit(GetPokemonListSuccess(pokemonList: combined));
    });
  }
}
