import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'get_pokemon_list_state.dart';

@injectable
class GetPokemonListCubit extends Cubit<GetPokemonListState> {
  final GetPokemonListUseCase getPokemonListUseCase;

  GetPokemonListCubit(this.getPokemonListUseCase) : super(GetPokemonListState());

  Future<void> getPokemonList() async {
    emit(state.copyWith(status: NetworkStatusEnum.isLoading));

    final response = await getPokemonListUseCase(GetPokemonListRequest(offset: 0, limit: 50)).run();

    response.match(
      (err) => emit(state.copyWith(status: NetworkStatusEnum.isError, errorMessage: err.message)),
      (list) => emit(state.copyWith(status: NetworkStatusEnum.isSuccess, pokemonList: list)),
    );
  }

  Future<void> loadMore() async {
    final currentList = state.pokemonList;

    final response = await getPokemonListUseCase(GetPokemonListRequest(offset: currentList.length, limit: 50)).run();

    response.match((err) => emit(state.copyWith(status: NetworkStatusEnum.isError, errorMessage: err.message)), (
      newList,
    ) {
      emit(state.copyWith(pokemonList: [...currentList, ...newList]));
    });
  }
}
