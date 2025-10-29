import 'dart:async';

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
  Timer? _debounce;

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

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text.trim();
      final baseList = context.read<GetPokemonListCubit>().state.pokemonList;
      context.read<FilterPokemonListCubit>().filterPokemonList(query, baseList);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SortDialogWidget(
        onUpward: () {
          final baseList = context.read<GetPokemonListCubit>().state.pokemonList;
          context.read<FilterPokemonListCubit>().filterPokemonList('', baseList);
          context.read<SortPokemonListCubit>().applySort(SortOptions.nameAsc, baseList);
          context.pop();
        },
        onDownWard: () {
          final baseList = context.read<GetPokemonListCubit>().state.pokemonList;
          context.read<FilterPokemonListCubit>().filterPokemonList('', baseList);
          context.read<SortPokemonListCubit>().applySort(SortOptions.nameDesc, baseList);
          context.pop();
        },
        onById: () {
          final baseList = context.read<GetPokemonListCubit>().state.pokemonList;
          context.read<FilterPokemonListCubit>().filterPokemonList('', baseList);
          context.read<SortPokemonListCubit>().applySort(SortOptions.byId, baseList);
          context.pop();
        },
      ),
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
          child: MultiBlocListener(
            listeners: [
              BlocListener<GetPokemonListCubit, GetPokemonListState>(
                listener: (context, state) {
                  if (state.status == NetworkStatusEnum.isSuccess) {
                    final baseList = state.pokemonList;

                    final currentOption = context.read<SortPokemonListCubit>().state.sortOption;
                    context.read<SortPokemonListCubit>().applySort(currentOption, baseList);
                  }
                },
              ),
              BlocListener<FilterPokemonListCubit, FilterPokemonListState>(
                listener: (context, filterState) {
                  final filtered = filterState.filteredList;

                  final currentOption = context.read<SortPokemonListCubit>().state.sortOption;
                  context.read<SortPokemonListCubit>().applySort(currentOption, filtered);
                },
              ),
            ],
            child: BlocBuilder<GetPokemonListCubit, GetPokemonListState>(
              builder: (_, pokemonListState) {
                if (pokemonListState.status == NetworkStatusEnum.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (pokemonListState.status == NetworkStatusEnum.isError) {
                  return Center(child: Text(pokemonListState.errorMessage));
                }

                if (pokemonListState.status == NetworkStatusEnum.isSuccess) {
                  return BlocBuilder<SortPokemonListCubit, SortPokemonListState>(
                    builder: (context, sortState) {
                      final displayedList = sortState.sortedPokemonList.isNotEmpty
                          ? sortState.sortedPokemonList
                          : pokemonListState.pokemonList;

                      return GridView.builder(
                        controller: _scrollController,
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
