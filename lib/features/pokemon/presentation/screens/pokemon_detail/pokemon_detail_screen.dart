import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class PokemonDetailScreen extends StatelessWidget {
  static final path = RoutePathsEnum.pokemonDetail.path;
  static final name = RoutePathsEnum.pokemonDetail.name;

  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: EdgeInsetsGeometry.all(8), child: Container()),
      ),
    );
  }
}
