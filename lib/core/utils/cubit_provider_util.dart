import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';
import '../core.dart';

final cubitProviderUtil = [
  BlocProvider<PokemonListCubit>(create: (context) => sl<PokemonListCubit>()),
  BlocProvider<PokemonFavoriteCubit>(create: (context) => sl<PokemonFavoriteCubit>()),
  // Provide the PokemonDetailCubit (detail-focused) for screens that show details.
  BlocProvider<PokemonDetailCubit>(create: (context) => sl<PokemonDetailCubit>()),
];
