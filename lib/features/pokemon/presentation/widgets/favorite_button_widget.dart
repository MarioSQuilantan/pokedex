import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/pokemon.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final int pokemonId;
  final String pokemonName;
  final String pokemonImagePath;

  const FavoriteButtonWidget({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
    required this.pokemonImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoritePokemonListCubit, GetFavoritePokemonListState>(
      builder: (context, favState) {
        final isFavorite = favState.favoritePokemonList.any((p) => p.id == pokemonId);

        final deleteCubit = context.read<DeleteFavoritePokemonCubit>();
        final insertCubit = context.read<InsertFavoritePokemonCubit>();
        final favCubit = context.read<GetFavoritePokemonListCubit>();

        return IconButton(
          onPressed: () async {
            if (isFavorite) {
              await deleteCubit.deleteFavoritePokemon(pokemonId);
            } else {
              await insertCubit.insertFavoritePokemon(id: pokemonId, name: pokemonName, imagePath: pokemonImagePath);
            }

            await favCubit.getFavoritePokemonList();
          },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
        );
      },
    );
  }
}
