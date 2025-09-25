import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class PokemonDetailScreen extends StatefulWidget {
  static final path = RoutePathsEnum.pokemonDetail.path;
  static final name = RoutePathsEnum.pokemonDetail.name;

  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<PokemonCubit>();
      cubit.onGetPokemonDetailById(id: widget.pokemonId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutWidget(
        mobileView: PokemonDetailMobileView(),
        desktopView: PokemonDetailMobileView(),
        tabletView: PokemonDetailMobileView(),
      ),
    );
  }
}
