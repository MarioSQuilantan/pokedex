import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pokedex/core/core.dart';
import 'package:pokedex/features/features.dart';

class PokemonListScreen extends StatefulWidget {
  static final path = RoutePathsEnum.pokemonList.path;
  static final name = RoutePathsEnum.pokemonList.name;

  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (!_scrollController.hasClients) return;
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll <= 300) {
          context.read<GetPokemonListCubit>().loadMore();
        }
      });
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {}

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SortDialogWidget(onUpward: () {}, onDownWard: () {}, onById: () {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF5959),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pokédex', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              context.push(RoutePathsEnum.favoritePokemonList.path);
            },
          ),
          const Gap(10),
          IconButton(icon: const Icon(Icons.tune), color: Colors.black, onPressed: () => _openSortDialog(context)),
          const Gap(10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<GetPokemonListCubit, GetPokemonListState>(
            listener: (context, state) {
              if (state.status == NetworkStatusEnum.isSuccess) {}
            },
            child: BlocBuilder<GetPokemonListCubit, GetPokemonListState>(
              builder: (_, pokemonListState) {
                if (pokemonListState.status == NetworkStatusEnum.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (pokemonListState.status == NetworkStatusEnum.isError) {
                  return Center(child: Text(pokemonListState.errorMessage));
                }

                if (pokemonListState.status == NetworkStatusEnum.isSuccess) {
                  return GridView.builder(
                    controller: _scrollController,
                    itemCount: pokemonListState.pokemonList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final pokemon = pokemonListState.pokemonList[index];

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
      ),
    );
  }
}
