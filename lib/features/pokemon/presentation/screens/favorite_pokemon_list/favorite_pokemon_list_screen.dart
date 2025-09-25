import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class FavoritePokemonListScreen extends StatefulWidget {
  static final path = RoutePathsEnum.favoritePokemonList.path;
  static final name = RoutePathsEnum.favoritePokemonList.name;

  const FavoritePokemonListScreen({super.key});

  @override
  State<FavoritePokemonListScreen> createState() => _FavoritePokemonListScreenState();
}

class _FavoritePokemonListScreenState extends State<FavoritePokemonListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favCubit = context.read<PokemonFavoriteCubit>();
      favCubit.onGetFavoritePokemonList();
    });
  }

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
