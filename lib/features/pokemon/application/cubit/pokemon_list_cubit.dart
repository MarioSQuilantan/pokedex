import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../application.dart';
import '../../domain/domain.dart';
import '../../data/data.dart';
import 'sort_mode.dart' as sm;

@lazySingleton
class PokemonListCubit extends Cubit<PokemonItemsState> {
  final GetPokemonListUseCase _getPokemonListUseCase;

  PokemonListCubit(this._getPokemonListUseCase) : super(PokemonItemsInitial());

  final List<PokemonEntity> _accumulator = [];
  int _offset = 0;
  final int _limit = 50;
  bool _isFetching = false;
  String _filter = '';
  bool _hasMore = true;
  sm.PokemonSortMode _sortMode = sm.PokemonSortMode.none;

  Future<void> onGetPokemonList({int offset = 0, int limit = 100}) async {
    if (_isFetching) return;
    _isFetching = true;
    emit(PokemonItemsLoading());
    _offset = 0;
    _accumulator.clear();
    final either = await _getPokemonListUseCase(GetPokemonListRequest(offset: _offset, limit: _limit)).run();
    either.fold(
      (l) {
        _isFetching = false;
        emit(PokemonItemsFailure(l.message));
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
    if (current is! PokemonItemsLoaded) return;
    if (!current.hasMore) return;

    _isFetching = true;
    emit(PokemonItemsLoaded(List.from(_accumulator), hasMore: true, isLoadingMore: true));

    final either = await _getPokemonListUseCase(GetPokemonListRequest(offset: _offset, limit: _limit)).run();
    either.fold(
      (l) {
        _isFetching = false;
        emit(PokemonItemsFailure(l.message));
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

  void sortByName({required bool ascending}) {
    final current = state;
    if (current is! PokemonItemsLoaded) return;
    _accumulator.sort((a, b) {
      final an = a.name.toLowerCase();
      final bn = b.name.toLowerCase();
      return ascending ? an.compareTo(bn) : bn.compareTo(an);
    });
    _sortMode = ascending ? sm.PokemonSortMode.nameAsc : sm.PokemonSortMode.nameDesc;
    _emitList(isLoadingMore: current.isLoadingMore);
  }

  void onSortUpward() => sortByName(ascending: true);

  void onSortDownward() => sortByName(ascending: false);

  void sortById({bool ascending = true}) {
    final current = state;
    if (current is! PokemonItemsLoaded) return;
    _accumulator.sort((a, b) => ascending ? a.id.compareTo(b.id) : b.id.compareTo(a.id));
    _sortMode = ascending ? sm.PokemonSortMode.idAsc : sm.PokemonSortMode.idDesc;
    _emitList(isLoadingMore: current.isLoadingMore);
  }

  void onSortById() => sortById(ascending: true);

  void filterBy(String query) {
    _filter = query.trim().toLowerCase();
    _emitList();
  }

  void _applySortToAccumulator() {
    switch (_sortMode) {
      case sm.PokemonSortMode.nameAsc:
        _accumulator.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case sm.PokemonSortMode.nameDesc:
        _accumulator.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case sm.PokemonSortMode.idAsc:
        _accumulator.sort((a, b) => a.id.compareTo(b.id));
        break;
      case sm.PokemonSortMode.idDesc:
        _accumulator.sort((a, b) => b.id.compareTo(a.id));
        break;
      case sm.PokemonSortMode.none:
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

    emit(PokemonItemsLoaded(filtered, hasMore: _hasMore, isLoadingMore: isLoadingMore));
  }

  void emitCurrentList() {
    _emitList(isLoadingMore: false);
  }
}
