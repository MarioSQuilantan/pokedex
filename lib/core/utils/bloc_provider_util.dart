import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';
import '../core.dart';

final List<BlocProvider> blocProviderUtil = [
  BlocProvider<GetPokemonListCubit>(create: (context) => sl<GetPokemonListCubit>()..getPokemonList()),
  BlocProvider<GetFavoritePokemonListCubit>(
    create: (context) => sl<GetFavoritePokemonListCubit>()..getFavoritePokemonList(),
  ),
  BlocProvider<SortPokemonListCubit>(create: (context) => sl<SortPokemonListCubit>()),
  BlocProvider<FilterPokemonListCubit>(create: (context) => sl<FilterPokemonListCubit>()),
  BlocProvider<DeleteFavoritePokemonCubit>(create: (context) => sl<DeleteFavoritePokemonCubit>()),
  BlocProvider<InsertFavoritePokemonCubit>(create: (context) => sl<InsertFavoritePokemonCubit>()),
];
