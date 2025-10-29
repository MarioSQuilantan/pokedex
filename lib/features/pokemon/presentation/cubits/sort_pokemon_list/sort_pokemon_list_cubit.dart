import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/features.dart';

part 'sort_pokemon_list_state.dart';

@injectable
class SortPokemonListCubit extends Cubit<SortPokemonListState> {
  SortPokemonListCubit() : super(SortPokemonListState());

  void sortById(SortOptions option, List<PokemonEntity> baseList) {
    final sorted = baseList;
    sorted.sort((a, b) => a.id.compareTo(b.id));
    emit(state.copyWith(sortedPokemonList: sorted));
  }

  void sortNameAsc(SortOptions option, List<PokemonEntity> baseList) {
    final sorted = baseList;
    sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    emit(state.copyWith(sortedPokemonList: sorted));
  }

  void sortByNameDesc(SortOptions option, List<PokemonEntity> baseList) {
    final sorted = baseList;
    sorted.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    emit(state.copyWith(sortedPokemonList: sorted));
  }
}
