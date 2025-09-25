import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/cubit/pokemon_cubit.dart';
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
      final cubit = context.read<PokemonCubit>();
      if (cubit.state is! PokemonFavoriteListLoaded) {
        cubit.onGetFavoritePokemonList();
      }
    });
  }

  void _onFavoriteChanged() {
    final cubit = context.read<PokemonCubit>();
    cubit.onGetFavoritePokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite pokemon list'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            final cubit = context.read<PokemonCubit>();
            context.pop();
            cubit.emitCurrentList();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<PokemonCubit, PokemonState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PokemonLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PokemonFailure) {
                return Center(child: Text(state.message));
              }

              if (state is PokemonFavoriteListLoaded) {
                final pokemons = state.pokemonFavoriteList;

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
                        final cubit = context.read<PokemonCubit>();
                        await context.pushNamed(PokemonDetailScreen.name, pathParameters: {'id': '${pokemon.id}'});
                        cubit.emitFavoriteList();
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
