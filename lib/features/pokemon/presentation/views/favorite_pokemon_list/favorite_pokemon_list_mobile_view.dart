import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/cubit/pokemon_favorite_cubit.dart';
import '../../../application/cubit/pokemon_list_cubit.dart';
import '../../../application/cubit/pokemon_favorite_state.dart';
import '../../presentation.dart';

class FavoritePokemonListMobileView extends StatefulWidget {
  const FavoritePokemonListMobileView({super.key});

  @override
  State<FavoritePokemonListMobileView> createState() => _FavoritePokemonListMobileViewState();
}

class _FavoritePokemonListMobileViewState extends State<FavoritePokemonListMobileView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favCubit = context.read<PokemonFavoriteCubit>();
      if (favCubit.state is! PokemonFavoriteLoaded) {
        favCubit.onGetFavoritePokemonList();
      }
    });
  }

  void _onFavoriteChanged() {
    final favCubit = context.read<PokemonFavoriteCubit>();
    favCubit.onGetFavoritePokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite pokemon list'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            final listCubit = context.read<PokemonListCubit>();
            context.pop();
            listCubit.emitCurrentList();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<PokemonFavoriteCubit, PokemonFavoriteState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PokemonFavoriteLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PokemonFavoriteFailure) {
                return Center(child: Text(state.message));
              }

              if (state is PokemonFavoriteLoaded) {
                final pokemons = state.favoriteList;

                if (pokemons.isEmpty) {
                  return const Center(
                    child: Text('No hay Pokémon favoritos', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  );
                }

                return GridView.builder(
                  itemCount: pokemons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];
                    return ImageCardWidget(
                      key: ValueKey(pokemon.id),
                      pokemon: pokemon,
                      updateFavoriteList: true,
                      onFavoriteChanged: _onFavoriteChanged,
                      onTap: () async {
                        final favCubit = context.read<PokemonFavoriteCubit>();
                        final listCubit = context.read<PokemonListCubit>();
                        await context.pushNamed(PokemonDetailScreen.name, pathParameters: {'id': '${pokemon.id}'});
                        favCubit.onGetFavoritePokemonList();
                        listCubit.emitCurrentList();
                      },
                    );
                  },
                );
              }

              return const Center(
                child: Text(
                  'Presiona el botón de favoritos para cargar la lista',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
