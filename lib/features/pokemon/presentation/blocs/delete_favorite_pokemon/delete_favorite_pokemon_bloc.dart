import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../features.dart';

part 'delete_favorite_pokemon_event.dart';
part 'delete_favorite_pokemon_state.dart';

@injectable
class DeleteFavoritePokemonBloc extends Bloc<DeleteFavoritePokemonEvent, DeleteFavoritePokemonState> {
  final DeleteFavoritePokemonUseCase deleteFavoritePokemonUseCase;
  DeleteFavoritePokemonBloc(this.deleteFavoritePokemonUseCase) : super(DeleteFavoritePokemonInitial()) {
    on<DeleteFavoritePokemon>(_deleteFavoritePokemon);
  }

  Future<void> _deleteFavoritePokemon(DeleteFavoritePokemon event, Emitter<DeleteFavoritePokemonState> emit) async {
    final response = await deleteFavoritePokemonUseCase(DeleteFavoritePokemonRequest(id: event.id)).run();

    response.match(
      (err) => emit(DeleteFavoritePokemonError(message: err.toString())),
      (values) => emit(DeleteFavoritePokemonSuccess()),
    );
  }
}
