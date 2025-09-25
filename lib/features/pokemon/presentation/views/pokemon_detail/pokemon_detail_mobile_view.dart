import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../application/application.dart';
import '../../presentation.dart';

class PokemonDetailMobileView extends StatelessWidget {
  const PokemonDetailMobileView({super.key});

  Widget buildStatRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 30, child: Text(value.toString())),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  String statLabel(int idx) {
    switch (idx) {
      case 0:
        return 'HP';
      case 1:
        return 'ATK';
      case 2:
        return 'DEF';
      case 3:
        return 'SATK';
      case 4:
        return 'SDEF';
      case 5:
        return 'SPD';
      default:
        return 'STAT$idx';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PokemonFailure) {
          return Scaffold(
            backgroundColor: Colors.red,
            body: SafeArea(
              child: Center(
                child: Text(state.message, style: const TextStyle(color: Colors.white)),
              ),
            ),
          );
        }

        if (state is PokemonDetailLoaded) {
          final pokemon = state.pokemonDetail;
          return Scaffold(
            backgroundColor: pokemon.background,
            body: SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          color: Colors.white,
                          onPressed: () {
                            final cubit = context.read<PokemonCubit>();
                            context.pop();
                            cubit.emitCurrentList();
                          },
                        ),
                        Text(
                          pokemon.name,
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        Row(
                          children: <Widget>[
                            FavoriteButtonWidget(id: pokemon.id.toInt()),
                            Text(pokemonIdFormatterUtil(pokemon.id.toInt()), style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Pokémon Image
                  Image.network(pokemon.imageUrl, height: 150, fit: BoxFit.contain),

                  // Info container
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
                            GapWidget(16),
                            Text(
                              "About",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: pokemon.background),
                            ),
                            GapWidget(12),
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
                                          GapWidget(4),
                                          Text(
                                            "${pokemon.weight} kg",
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      GapWidget(8),
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
                                          GapWidget(4),
                                          Text(
                                            "${pokemon.height} m",
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      GapWidget(8),
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
                                          GapWidget(4),
                                          Text(
                                            '${pokemon.baseExperience}',
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      GapWidget(8),
                                      Text("Base experience", style: TextStyle(fontSize: 12, color: Colors.black54)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            GapWidget(24),
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
                                  const GapWidget(8),
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

                            GapWidget(24),
                            Text(
                              "Base Stats",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: pokemon.background),
                            ),
                            GapWidget(12),
                            Column(
                              children: pokemon.stats
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => buildStatRow(
                                      statLabel(e.key),
                                      e.value.toInt(),
                                      pokemon.types.isNotEmpty ? pokemon.types[0].background : Colors.blue,
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

        // default empty
        return const SizedBox.shrink();
      },
    );
  }
}
