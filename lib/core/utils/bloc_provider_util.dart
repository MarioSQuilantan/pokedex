import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';
import '../core.dart';

final List<BlocProvider> blocProviderUtil = [
  BlocProvider<GetPokemonListCubit>(create: (context) => sl<GetPokemonListCubit>()..getPokemonList()),
  BlocProvider<SortPokemonListCubit>(create: (context) => sl<SortPokemonListCubit>()),
  BlocProvider<FilterPokemonListCubit>(create: (context) => sl<FilterPokemonListCubit>()),
];
