import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'insert_favorite_pokemon_state.dart';

@injectable
class InsertFavoritePokemonCubit extends Cubit<InsertFavoritePokemonState> {
  final InsertFavoritePokemonUseCase insertFavoritePokemonUseCase;

  InsertFavoritePokemonCubit(this.insertFavoritePokemonUseCase) : super(InsertFavoritePokemonState());

  Future<void> insertFavoritePokemon(int id, String name, String imagePath) async {
    emit(state.copyWith(status: NetworkStatusEnum.isLoading));

    final request = InsertFavoritePokemonRequest(id: id, name: name, imagePath: imagePath);

    final response = await insertFavoritePokemonUseCase(request).run();

    response.match(
      (err) => emit(state.copyWith(status: NetworkStatusEnum.isError, errorMessage: err.message)),
      (values) => emit(state.copyWith(status: NetworkStatusEnum.isSuccess)),
    );
  }
}
