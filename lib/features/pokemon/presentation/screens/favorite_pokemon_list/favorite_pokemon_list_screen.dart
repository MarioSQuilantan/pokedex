import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class FavoritePokemonListScreen extends StatelessWidget {
  static final path = RoutePathsEnum.favoritePokemonList.path;
  static final name = RoutePathsEnum.favoritePokemonList.name;

  const FavoritePokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutWidget(
        mobileView: FavoritePokemonListMobileView(),
        desktopView: FavoritePokemonListMobileView(),
        tabletView: FavoritePokemonListMobileView(),
      ),
    );
  }
}
