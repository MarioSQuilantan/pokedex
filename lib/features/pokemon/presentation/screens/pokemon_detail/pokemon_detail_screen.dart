import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/core.dart';
import '../../../../features.dart';

class PokemonDetailScreen extends StatelessWidget {
  static final path = RoutePathsEnum.pokemonDetail.path;
  static final name = RoutePathsEnum.pokemonDetail.name;

  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<GetPokemonDetailByIdCubit>()..getFavoritePokemonList(pokemonId),
      child: BlocBuilder<GetPokemonDetailByIdCubit, GetPokemonDetailByIdState>(
        builder: (context, state) {
          if (state.status == NetworkStatusEnum.isLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state.status == NetworkStatusEnum.isError) {
            return Scaffold(body: Center(child: Text(state.errorMessage)));
          }

          if (state.status == NetworkStatusEnum.isSuccess) {
            final pokemon = state.pokemonDetail!;
            return Scaffold(
              backgroundColor: pokemon.background,
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            color: Colors.white,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                          Text(
                            pokemon.name,
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),

                          Row(
                            children: <Widget>[
                              FavoriteButtonWidget(
                                pokemonId: pokemon.id.toInt(),
                                pokemonName: pokemon.name,
                                pokemonImagePath: pokemon.imageUrl,
                              ),
                              Text(pokemonIdFormatterUtil(pokemon.id.toInt()), style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    CachedNetworkImage(
                      imageUrl: pokemon.imageUrl,
                      height: 150,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error, size: 64, color: Colors.red)),
                    ),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: pokemon.types
                                    .map(
                                      (t) => Container(
                                        margin: EdgeInsets.symmetric(horizontal: 4),
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: t.background,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(t.type, style: TextStyle(color: Colors.white)),
                                      ),
                                    )
                                    .toList(),
                              ),
                              Gap(16),
                              Text(
                                "About",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: pokemon.background),
                              ),
                              Gap(12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.monitor_weight_outlined, size: 20),
                                            Gap(4),
                                            Text(
                                              "${pokemon.weight} kg",
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Gap(8),
                                        Text("Weight", style: TextStyle(fontSize: 12, color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.height, size: 20),
                                            Gap(4),
                                            Text(
                                              "${pokemon.height} m",
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Gap(8),
                                        Text("Height", style: TextStyle(fontSize: 12, color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(Icons.grass, size: 20),
                                            Gap(4),
                                            Text(
                                              '${pokemon.baseExperience}',
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Gap(8),
                                        Text("Base experience", style: TextStyle(fontSize: 12, color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Gap(24),
                              if (pokemon.abilities.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Abilities',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: pokemon.background,
                                      ),
                                    ),
                                    const Gap(8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: pokemon.abilities
                                          .map(
                                            (a) => Chip(
                                              label: Text(a, style: TextStyle(fontSize: 12, color: Colors.grey[200])),
                                              backgroundColor: pokemon.background,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),

                              Gap(24),
                              Text(
                                "Base Stats",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: pokemon.background),
                              ),
                              Gap(12),
                              Column(
                                children: pokemon.stats
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => StarRowsWidget(
                                        keyLabel: e.key,
                                        value: e.value,
                                        color: pokemon.types.isNotEmpty ? pokemon.types[0].background : Colors.blue,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
