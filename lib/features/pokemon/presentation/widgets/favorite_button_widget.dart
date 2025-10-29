import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/pokemon.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final PokemonEntity pokemon;

  const FavoriteButtonWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoritePokemonListCubit, GetFavoritePokemonListState>(
      builder: (context, favState) {
        final isFavorite = favState.favoritePokemonList.any((p) => p.id == pokemon.id);

        final deleteCubit = context.read<DeleteFavoritePokemonCubit>();
        final insertCubit = context.read<InsertFavoritePokemonCubit>();
        final favCubit = context.read<GetFavoritePokemonListCubit>();

        return IconButton(
          onPressed: () async {
            if (isFavorite) {
              await deleteCubit.deleteFavoritePokemon(pokemon.id);
            } else {
              await insertCubit.insertFavoritePokemon(id: pokemon.id, name: pokemon.name, imagePath: pokemon.imagePath);
            }

            await favCubit.getFavoritePokemonList();
          },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
        );
      },
    );
  }
}
