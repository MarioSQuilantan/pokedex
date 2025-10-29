import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'get_favorite_pokemon_list_state.dart';

@injectable
class GetFavoritePokemonListCubit extends Cubit<GetFavoritePokemonListState> {
  final GetFavoritePokemonListUseCase getFavoritePokemonListUseCase;

  GetFavoritePokemonListCubit(this.getFavoritePokemonListUseCase) : super(GetFavoritePokemonListState());

  Future<void> getFavoritePokemonList() async {
    emit(state.copyWith(status: NetworkStatusEnum.isLoading));

    final response = await getFavoritePokemonListUseCase().run();

    response.match(
      (err) => emit(state.copyWith(status: NetworkStatusEnum.isError, errorMessage: err.message)),
      (list) => emit(state.copyWith(status: NetworkStatusEnum.isSuccess, favoritePokemonList: list)),
    );
  }
}
