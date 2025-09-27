import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class PokemonListScreen extends StatelessWidget {
  static final path = RoutePathsEnum.pokemonList.path;
  static final name = RoutePathsEnum.pokemonList.name;

  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutWidget(
        mobileView: PokemonListMobileView(),
        desktopView: PokemonListMobileView(),
        tabletView: PokemonListMobileView(),
      ),
    );
  }
}
