import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/features.dart';

part 'sort_pokemon_list_state.dart';

@injectable
class SortPokemonListCubit extends Cubit<SortPokemonListState> {
  SortPokemonListCubit() : super(const SortPokemonListState());

  void applySort(SortOptions option, List<PokemonEntity> baseList) {
    final sorted = List<PokemonEntity>.from(baseList);

    switch (option) {
      case SortOptions.nameAsc:
        sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortOptions.nameDesc:
        sorted.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case SortOptions.byId:
        sorted.sort((a, b) => a.id.compareTo(b.id));
        break;
    }

    final current = state.sortedPokemonList;
    var equal = false;
    if (current.length == sorted.length) {
      equal = true;
      for (var i = 0; i < current.length; i++) {
        if (current[i].id != sorted[i].id) {
          equal = false;
          break;
        }
      }
    }

    if (!equal || state.sortOption != option) {
      emit(state.copyWith(sortedPokemonList: UnmodifiableListView(sorted).toList(), sortOption: option));
    }
  }
}
