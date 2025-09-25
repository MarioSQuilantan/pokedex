import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../application/application.dart';

import '../../presentation.dart';

class PokemonListMobileView extends StatefulWidget {
  const PokemonListMobileView({super.key});

  @override
  State<PokemonListMobileView> createState() => _PokemonListMobileViewState();
}

class _PokemonListMobileViewState extends State<PokemonListMobileView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<PokemonCubit>();

      _scrollController.addListener(() {
        if (!_scrollController.hasClients) return;
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll <= 300) {
          cubit.loadMore();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF5959),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Pokédex', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              context.pushNamed(FavoritePokemonListScreen.name);
            },
          ),
          GapWidget(10),
          IconButton(
            icon: const Icon(Icons.tune),
            color: Colors.black,
            onPressed: () {
              final cubit = context.read<PokemonCubit>();
              showDialog(
                context: context,
                builder: (_) => SortDialogWidget(
                  onUpward: () {
                    _searchController.clear();
                    cubit.filterBy('');
                    cubit.onSortUpward();
                    context.pop();
                  },
                  onDownWard: () {
                    _searchController.clear();
                    cubit.filterBy('');
                    cubit.onSortDownward();
                    context.pop();
                  },
                  onById: () {
                    _searchController.clear();
                    cubit.filterBy('');
                    cubit.onSortById();
                    context.pop();
                  },
                ),
              );
            },
          ),
          GapWidget(10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => context.read<PokemonCubit>().filterBy(value),
              decoration: const InputDecoration(
                hintText: 'Buscar Pokémon',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PokemonCubit, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PokemonFailure) {
              return Center(child: Text(state.message));
            }

            if (state is PokemonListLoaded) {
              final pokemons = state.pokemonList;

              return GridView.builder(
                itemCount: pokemons.length,
                controller: _scrollController,
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
                    onTap: () {
                      context.pushNamed(PokemonDetailScreen.name, pathParameters: {'id': '${pokemon.id}'});
                    },
                  );
                },
              );
            }

            // default empty state
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
