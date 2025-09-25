import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../application.dart';
import '../../data/requests/insert_favorite_pokemon_request.dart';
import '../../data/requests/delete_favorite_pokemon_request.dart';

@lazySingleton
class PokemonFavoriteCubit extends Cubit<PokemonFavoriteState> {
  final GetFavoritePokemonListUseCase _getFavoritePokemonListUseCase;
  final InsertFavoritePokemonUseCase _insertFavoritePokemonUseCase;
  final DeleteFavoritePokemonUseCase _deleteFavoritePokemonUseCase;

  PokemonFavoriteCubit(
    this._getFavoritePokemonListUseCase,
    this._insertFavoritePokemonUseCase,
    this._deleteFavoritePokemonUseCase,
  ) : super(PokemonFavoriteInitial());

  final List<PokemonEntity> _favoriteAccumulator = [];
  bool _isFetchingFavorites = false;

  Future<void> onGetFavoritePokemonList() async {
    if (_isFetchingFavorites) return;
    _isFetchingFavorites = true;
    emit(PokemonFavoriteLoading());

    final favoritePokemons = await _getFavoritePokemonListUseCase();
    _isFetchingFavorites = false;
    _favoriteAccumulator.clear();
    _favoriteAccumulator.addAll(favoritePokemons);
    emit(PokemonFavoriteLoaded(List<PokemonEntity>.from(_favoriteAccumulator)));
  }

  Future<List<PokemonEntity>> loadFavoritesSilently() async {
    if (_isFetchingFavorites) return List<PokemonEntity>.from(_favoriteAccumulator);
    _isFetchingFavorites = true;
    final favoritePokemons = await _getFavoritePokemonListUseCase();
    _isFetchingFavorites = false;
    _favoriteAccumulator.clear();
    _favoriteAccumulator.addAll(favoritePokemons);
    return List<PokemonEntity>.from(_favoriteAccumulator);
  }

  Future<void> addPokemonToFavorites(PokemonEntity pokemon) async {
    final request = InsertFavoritePokemonRequest(id: pokemon.id, name: pokemon.name, imagePath: pokemon.imagePath);
    await _insertFavoritePokemonUseCase(request);
    if (!_favoriteAccumulator.any((p) => p.id == pokemon.id)) {
      _favoriteAccumulator.add(pokemon);
    }
    emit(PokemonFavoriteLoaded(List<PokemonEntity>.from(_favoriteAccumulator)));
  }

  Future<void> removePokemonFromFavorites(int pokemonId) async {
    final request = DeleteFavoritePokemonRequest(id: pokemonId);
    await _deleteFavoritePokemonUseCase(request);
    _favoriteAccumulator.removeWhere((p) => p.id == pokemonId);
    emit(PokemonFavoriteLoaded(List<PokemonEntity>.from(_favoriteAccumulator)));
  }

  bool isPokemonFavorite(int pokemonId) => _favoriteAccumulator.any((p) => p.id == pokemonId);

  bool get hasLoadedFavorites => _favoriteAccumulator.isNotEmpty;
}
