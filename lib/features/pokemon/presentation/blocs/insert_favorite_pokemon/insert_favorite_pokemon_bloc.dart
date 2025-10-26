import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../features.dart';

part 'insert_favorite_pokemon_event.dart';
part 'insert_favorite_pokemon_state.dart';

@injectable
class InsertFavoritePokemonBloc extends Bloc<InsertFavoritePokemonEvent, InsertFavoritePokemonState> {
  final InsertFavoritePokemonUseCase insertFavoritePokemonUseCase;

  InsertFavoritePokemonBloc(this.insertFavoritePokemonUseCase) : super(InsertFavoritePokemonInitial()) {
    on<InsertFavoritePokemon>(_insertFavoritePokemon);
  }

  Future<void> _insertFavoritePokemon(InsertFavoritePokemon event, Emitter<InsertFavoritePokemonState> emit) async {
    emit(InsertFavoritePokemonLoading());

    final response = await insertFavoritePokemonUseCase(
      InsertFavoritePokemonRequest(id: event.id, name: event.name, imagePath: event.imagePath),
    ).run();

    response.match(
      (err) => emit(InsertFavoritePokemonError(message: err.toString())),
      (values) => emit(InsertFavoritePokemonSuccess()),
    );
  }
}
