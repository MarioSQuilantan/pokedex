import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'delete_favorite_pokemon_state.dart';

@injectable
class DeleteFavoritePokemonCubit extends Cubit<DeleteFavoritePokemonState> {
  final DeleteFavoritePokemonUseCase deleteFavoritePokemonUseCase;

  DeleteFavoritePokemonCubit(this.deleteFavoritePokemonUseCase) : super(DeleteFavoritePokemonState());

  Future<void> deleteFavoritePokemon(int id) async {
    final response = await deleteFavoritePokemonUseCase(DeleteFavoritePokemonRequest(id: id)).run();

    response.match(
      (err) => emit(state.copyWith(status: NetworkStatusEnum.isError, errorMessage: err.message)),
      (_) => emit(state.copyWith(status: NetworkStatusEnum.isSuccess)),
    );

    emit(state.copyWith(status: null));
  }
}
