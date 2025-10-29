import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../features.dart';

part 'filter_pokemon_list_state.dart';

@injectable
class FilterPokemonListCubit extends Cubit<FilterPokemonListState> {
  FilterPokemonListCubit() : super(FilterPokemonListState());

  void filterPokemonList(String query, List<PokemonEntity> baseList) {
    final newQuery = query.trim().toLowerCase();

    if (newQuery.isEmpty) {
      emit(state.copyWith(filteredList: List.of(baseList)));
      return;
    }

    final filtered = baseList.where((p) => p.name.toLowerCase().contains(newQuery)).toList();
    emit(state.copyWith(filteredList: filtered));
  }
}
