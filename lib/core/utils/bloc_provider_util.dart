import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';
import '../core.dart';

final List<BlocProvider> blocProviderUtil = [
  BlocProvider<GetPokemonListBloc>(create: (context) => sl<GetPokemonListBloc>()..add(GetPokemonList())),
  BlocProvider<GetFavoritePokemonListBloc>(
    create: (context) => sl<GetFavoritePokemonListBloc>()..add(GetFavoritePokemonList()),
  ),
];
