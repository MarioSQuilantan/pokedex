import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class PokemonDetailScreen extends StatelessWidget {
  static final path = RoutePathsEnum.pokemonDetail.path;
  static final name = RoutePathsEnum.pokemonDetail.name;

  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailCubit>(
      create: (_) => sl<PokemonDetailCubit>()..onGetPokemonDetailById(id: pokemonId),
      child: Scaffold(
        body: ResponsiveLayoutWidget(
          mobileView: PokemonDetailMobileView(),
          desktopView: PokemonDetailMobileView(),
          tabletView: PokemonDetailMobileView(),
        ),
      ),
    );
  }
}
