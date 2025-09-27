import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final int id;
  final bool updateFavoriteList;
  final VoidCallback? onFavoriteChanged;

  const FavoriteButtonWidget({super.key, required this.id, this.updateFavoriteList = false, this.onFavoriteChanged});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokemonFavoriteCubit, PokemonFavoriteState, bool>(
      selector: (state) => (state is PokemonFavoriteLoaded) ? state.favoriteList.any((p) => p.id == id) : false,
      builder: (context, isFavorite) {
        return IconButton(
          onPressed: () async {
            final listCubit = context.read<PokemonListCubit>();
            final favCubit = context.read<PokemonFavoriteCubit>();
            final messenger = ScaffoldMessenger.of(context);
            final onChanged = onFavoriteChanged;

            final pokemon = listCubit.state is PokemonItemsLoaded
                ? (listCubit.state as PokemonItemsLoaded).items.firstWhere((p) => p.id == id)
                : null;

            final newFav = await favCubit.toggleFavoriteById(id: id, pokemon: pokemon);
            if (newFav) {
              messenger.showSnackBar(
                SnackBar(
                  content: Text('Pokémon agregado a favoritos'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              messenger.showSnackBar(
                SnackBar(
                  content: Text('Pokémon eliminado de favoritos'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            if (updateFavoriteList) onChanged?.call();
          },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
        );
      },
    );
  }
}
