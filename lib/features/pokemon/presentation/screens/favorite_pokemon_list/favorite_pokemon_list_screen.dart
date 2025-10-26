import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class FavoritePokemonListScreen extends StatelessWidget {
  static final path = RoutePathsEnum.favoritePokemonList.path;
  static final name = RoutePathsEnum.favoritePokemonList.name;

  const FavoritePokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(8.0), child: Container()),
      ),
    );
  }
}
