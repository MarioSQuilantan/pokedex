import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/pokemon/pokemon.dart';

import '../../../../../core/core.dart';

class FavoritePokemonListScreen extends StatelessWidget {
  static final path = RoutePathsEnum.favoritePokemonList.path;
  static final name = RoutePathsEnum.favoritePokemonList.name;

  const FavoritePokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF5959),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Pokédex', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<GetFavoritePokemonListCubit, GetFavoritePokemonListState>(
            builder: (context, state) {
              if (state.status == NetworkStatusEnum.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == NetworkStatusEnum.isError) {
                return Center(child: Text(state.errorMessage));
              }

              if (state.status == NetworkStatusEnum.isSuccess) {
                final displayedList = state.favoritePokemonList;

                return GridView.builder(
                  itemCount: displayedList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final pokemon = displayedList[index];

                    return ImageCardWidget(
                      key: ValueKey(pokemon.id),
                      pokemon: pokemon,
                      onTap: () {
                        context.pushNamed(PokemonDetailScreen.name, pathParameters: {'id': '${pokemon.id}'});
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
