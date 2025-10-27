import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/features.dart';

part 'filter_pokemon_list_event.dart';
part 'filter_pokemon_list_state.dart';

@injectable
class FilterPokemonListBloc extends Bloc<FilterPokemonListEvent, FilterPokemonListState> {
  FilterPokemonListBloc() : super(FilterPokemonListInitial()) {
    on<FilterByName>((event, emit) {
      final query = event.query.trim().toLowerCase();
      if (query.isEmpty) {
        emit(FilterPokemonListFiltered(List.of(event.baseList)));
        return;
      }

      final filtered = event.baseList.where((p) => p.name.toLowerCase().contains(query)).toList();
      emit(FilterPokemonListFiltered(filtered));
    });
  }
}
