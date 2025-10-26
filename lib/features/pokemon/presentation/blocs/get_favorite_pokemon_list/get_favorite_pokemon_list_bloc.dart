import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../features.dart';

part 'get_favorite_pokemon_list_event.dart';
part 'get_favorite_pokemon_list_state.dart';

@injectable
class GetFavoritePokemonListBloc extends Bloc<GetFavoritePokemonListEvent, GetFavoritePokemonListState> {
  final GetFavoritePokemonListUseCase getFavoritePokemonListUseCase;

  GetFavoritePokemonListBloc(this.getFavoritePokemonListUseCase) : super(GetFavoritePokemonListInitial()) {
    on<GetFavoritePokemonList>(_getFavoritePokemonList);
  }

  Future<void> _getFavoritePokemonList(GetFavoritePokemonList event, Emitter<GetFavoritePokemonListState> emit) async {
    emit(GetFavoritePokemonListLoading());

    final response = await getFavoritePokemonListUseCase().run();

    response.match(
      (err) => emit(GetFavoritePokemonListError(message: err.toString())),
      (values) => emit(GetFavoritePokemonListSuccess()),
    );
  }
}
