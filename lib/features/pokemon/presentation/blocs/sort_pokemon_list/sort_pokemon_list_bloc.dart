import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'sort_pokemon_list_event.dart';
part 'sort_pokemon_list_state.dart';

@injectable
class SortPokemonListBloc extends Bloc<SortPokemonListEvent, SortPokemonListState> {
  SortPokemonListBloc() : super(const SortPokemonListInitial()) {
    on<SortByNameAsc>((event, emit) => emit(const SortPokemonListOption(SortOption.nameAsc)));
    on<SortByNameDesc>((event, emit) => emit(const SortPokemonListOption(SortOption.nameDesc)));
    on<SortById>((event, emit) => emit(const SortPokemonListOption(SortOption.byId)));
    on<SortNone>((event, emit) => emit(const SortPokemonListOption(SortOption.none)));
  }
}
