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
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (!_scrollController.hasClients) return;
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll <= 300) {
          context.read<GetPokemonListBloc>().add(LoadMore());
        }
      });
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text.trim();
      _lastQuery = query;

      final getListState = context.read<GetPokemonListBloc>().state;
      final baseList = getListState is GetPokemonListSuccess ? getListState.pokemonList : <PokemonEntity>[];

      final targetBloc = context.read<FilterPokemonListBloc>();
      targetBloc.add(FilterByName(query: query, baseList: baseList));
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
          _searchController.clear();
          final getListState = context.read<GetPokemonListBloc>().state;
          final baseList = getListState is GetPokemonListSuccess ? getListState.pokemonList : <PokemonEntity>[];
          context.read<FilterPokemonListBloc>().add(FilterByName(query: '', baseList: baseList));
          context.read<SortPokemonListBloc>().add(const SortByNameAsc());
          context.pop();
        },
        onDownWard: () {
          _searchController.clear();
          final getListState = context.read<GetPokemonListBloc>().state;
          final baseList = getListState is GetPokemonListSuccess ? getListState.pokemonList : <PokemonEntity>[];
          context.read<FilterPokemonListBloc>().add(FilterByName(query: '', baseList: baseList));
          context.read<SortPokemonListBloc>().add(const SortByNameDesc());
          context.pop();
        },
        onById: () {
          _searchController.clear();
          final getListState = context.read<GetPokemonListBloc>().state;
          final baseList = getListState is GetPokemonListSuccess ? getListState.pokemonList : <PokemonEntity>[];
          context.read<FilterPokemonListBloc>().add(FilterByName(query: '', baseList: baseList));
          context.read<SortPokemonListBloc>().add(const SortById());
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
          child: BlocBuilder<GetPokemonListBloc, GetPokemonListState>(
            builder: (context, pokemonListState) {
              if (pokemonListState is GetPokemonListLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (pokemonListState is GetPokemonListError) {
                return Center(child: Text(pokemonListState.message));
              }

              if (pokemonListState is GetPokemonListSuccess) {
                return BlocBuilder<FilterPokemonListBloc, FilterPokemonListState>(
                  builder: (context, filterState) {
                    final sourceList = pokemonListState.pokemonList;
                    final filteredList = filterState is FilterPokemonListFiltered
                        ? filterState.filteredList
                        : sourceList;

                    return BlocBuilder<SortPokemonListBloc, SortPokemonListState>(
                      builder: (context, sortState) {
                        final displayedList = List.of(filteredList);

                        final option = sortState is SortPokemonListOption ? sortState.option : SortOption.none;

                        switch (option) {
                          case SortOption.nameAsc:
                            displayedList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                            break;
                          case SortOption.nameDesc:
                            displayedList.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
                            break;
                          case SortOption.byId:
                            displayedList.sort((a, b) => a.id.compareTo(b.id));
                            break;
                          case SortOption.none:
                            break;
                        }

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
