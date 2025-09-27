import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';
import '../core.dart';

final cubitProviderUtil = [
  BlocProvider<PokemonListCubit>(create: (context) => sl<PokemonListCubit>()..onGetPokemonList()),
  BlocProvider<PokemonFavoriteCubit>(create: (context) => sl<PokemonFavoriteCubit>()..onGetFavoritePokemonList()),
];
