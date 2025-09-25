import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../application.dart';
import '../../domain/domain.dart';
import '../../data/data.dart';

part 'pokemon_state.dart';

enum SortMode { none, nameAsc, nameDesc, idAsc, idDesc }

@lazySingleton
class PokemonCubit extends Cubit<PokemonState> {
  final GetPokemonListUseCase _getPokemonListUseCase;
  final GetPokemonDetailUseCase _getPokemonDetailUseCase;
  final GetFavoritePokemonListUseCase _getFavoritePokemonListUseCase;
  final InsertFavoritePokemonUseCase _insertFavoritePokemonUseCase;
  final DeleteFavoritePokemonUseCase _deleteFavoritePokemonUseCase;

  PokemonCubit(
    this._getPokemonListUseCase,
    this._getPokemonDetailUseCase,
    this._getFavoritePokemonListUseCase,
    this._insertFavoritePokemonUseCase,
    this._deleteFavoritePokemonUseCase,
  ) : super(PokemonInitial());

  final List<PokemonEntity> _accumulator = [];
  final List<PokemonEntity> _favoriteAccumulator = [];
  int _offset = 0;
  final int _limit = 50;
  bool _isFetching = false;
  bool _isFetchingFavorites = false;
  String _filter = '';
  bool _hasMore = true;
  SortMode _sortMode = SortMode.none;

  Future<void> onGetPokemonList({int offset = 0, int limit = 100}) async {
    if (_isFetching) return;
    _isFetching = true;
    emit(PokemonLoading());
    _offset = 0;
    _accumulator.clear();
    final either = await _getPokemonListUseCase(GetPokemonListRequest(offset: _offset, limit: _limit)).run();
    either.fold(
      (l) {
        _isFetching = false;
        emit(PokemonFailure(l.message));
      },
      (r) {
        _isFetching = false;
        _accumulator.addAll(r);
        _hasMore = r.length >= _limit;
        _applySortToAccumulator();
        _emitList(isLoadingMore: false);
        _offset += r.length;
      },
    );
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    final current = state;
    if (current is! PokemonListLoaded) return;
    if (!current.hasMore) return;

    _isFetching = true;
    emit(PokemonListLoaded(List.from(_accumulator), hasMore: true, isLoadingMore: true));

    final either = await _getPokemonListUseCase(GetPokemonListRequest(offset: _offset, limit: _limit)).run();
    either.fold(
      (l) {
        _isFetching = false;
        emit(PokemonFailure(l.message));
      },
      (r) {
        _isFetching = false;
        _accumulator.addAll(r);
        _hasMore = r.length >= _limit;
        _applySortToAccumulator();
        _emitList(isLoadingMore: false);
        _offset += r.length;
      },
    );
  }

  Future<void> onGetPokemonDetailById({required int id}) async {
    emit(PokemonLoading());
    final either = await _getPokemonDetailUseCase(GetPokemonDetailByIdRequest(id: id)).run();
    either.fold((l) => emit(PokemonFailure(l.message)), (r) => emit(PokemonDetailLoaded(r)));
  }

  Future<void> onGetFavoritePokemonList() async {
    if (_isFetchingFavorites) return;
    _isFetchingFavorites = true;
    emit(PokemonLoading());

    final favoritePokemons = await _getFavoritePokemonListUseCase();
    _isFetchingFavorites = false;
    _favoriteAccumulator.clear();
    _favoriteAccumulator.addAll(favoritePokemons);
    emit(PokemonFavoriteListLoaded(_favoriteAccumulator));
  }

  Future<void> loadFavoritesSilently() async {
    if (_isFetchingFavorites) return;
    _isFetchingFavorites = true;
    final favoritePokemons = await _getFavoritePokemonListUseCase();
    _isFetchingFavorites = false;
    _favoriteAccumulator.clear();
    _favoriteAccumulator.addAll(favoritePokemons);
  }

  Future<void> onAddPokemonToFavorites({required int id}) async {
    final pokemon = _accumulator.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Pokémon with id $id not found in list'),
    );

    final request = InsertFavoritePokemonRequest(id: pokemon.id, name: pokemon.name, imagePath: pokemon.imagePath);

    await _insertFavoritePokemonUseCase(request);
    if (!_favoriteAccumulator.any((p) => p.id == pokemon.id)) {
      _favoriteAccumulator.add(pokemon);
    }

    // Emitir inmediatamente el nuevo estado si estamos en la vista de favoritos
    final current = state;
    if (current is PokemonFavoriteListLoaded) {
      emit(PokemonFavoriteListLoaded(List.from(_favoriteAccumulator)));
    } else if (current is PokemonListLoaded) {
      // Re-emitir la lista principal para que widgets dependientes (ej. FavoriteButton)
      // detecten el cambio en favoritos y se reconstruyan.
      _emitList(isLoadingMore: current.isLoadingMore);
    }
  }

  Future<void> onRemovePokemonFromFavorites({required int pokemonId}) async {
    final request = DeleteFavoritePokemonRequest(id: pokemonId);
    await _deleteFavoritePokemonUseCase(request);
    _favoriteAccumulator.removeWhere((p) => p.id == pokemonId);
    final current = state;
    if (current is PokemonFavoriteListLoaded) {
      final newList = List<PokemonEntity>.from(_favoriteAccumulator);
      final newState = PokemonFavoriteListLoaded(newList);
      emit(newState);
    } else if (current is PokemonListLoaded) {
      _emitList(isLoadingMore: current.isLoadingMore);
    }
  }

  void sortByName({required bool ascending}) {
    final current = state;
    if (current is! PokemonListLoaded) return;
    _accumulator.sort((a, b) {
      final an = a.name.toLowerCase();
      final bn = b.name.toLowerCase();
      return ascending ? an.compareTo(bn) : bn.compareTo(an);
    });
    _sortMode = ascending ? SortMode.nameAsc : SortMode.nameDesc;
    _emitList(isLoadingMore: current.isLoadingMore);
  }

  void onSortUpward() => sortByName(ascending: true);

  void onSortDownward() => sortByName(ascending: false);

  void sortById({bool ascending = true}) {
    final current = state;
    if (current is! PokemonListLoaded) return;
    _accumulator.sort((a, b) => ascending ? a.id.compareTo(b.id) : b.id.compareTo(a.id));
    _sortMode = ascending ? SortMode.idAsc : SortMode.idDesc;
    _emitList(isLoadingMore: current.isLoadingMore);
  }

  void onSortById() => sortById(ascending: true);

  void filterBy(String query) {
    _filter = query.trim().toLowerCase();
    _emitList();
  }

  void _applySortToAccumulator() {
    switch (_sortMode) {
      case SortMode.nameAsc:
        _accumulator.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortMode.nameDesc:
        _accumulator.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case SortMode.idAsc:
        _accumulator.sort((a, b) => a.id.compareTo(b.id));
        break;
      case SortMode.idDesc:
        _accumulator.sort((a, b) => b.id.compareTo(a.id));
        break;
      case SortMode.none:
        break;
    }
  }

  void _emitList({bool isLoadingMore = false}) {
    final filtered = _filter.isEmpty
        ? List<PokemonEntity>.from(_accumulator)
        : _accumulator.where((p) {
            final name = p.name.toLowerCase();
            final idFormatted = pokemonIdFormatterUtil(p.id).toLowerCase();
            return name.contains(_filter) || idFormatted.contains(_filter);
          }).toList();

    emit(PokemonListLoaded(filtered, hasMore: _hasMore, isLoadingMore: isLoadingMore));
  }

  void emitCurrentList() {
    _emitList(isLoadingMore: false);
  }

  /// Emite explícitamente la lista de favoritos (solo usar cuando estés en la vista de favoritos)
  void emitFavoriteList() {
    emit(PokemonFavoriteListLoaded(List.from(_favoriteAccumulator)));
  }

  bool isPokemonFavorite(int pokemonId) {
    bool isInLocalAccumulator = _favoriteAccumulator.any((pokemon) => pokemon.id == pokemonId);

    if (state is PokemonFavoriteListLoaded) {
      final currentState = state as PokemonFavoriteListLoaded;
      bool isInCurrentState = currentState.pokemonFavoriteList.any((pokemon) => pokemon.id == pokemonId);
      return isInLocalAccumulator || isInCurrentState;
    }

    return isInLocalAccumulator;
  }

  /// Public helper to know if favorites were already loaded into the accumulator
  bool get hasLoadedFavorites => _favoriteAccumulator.isNotEmpty;
}
