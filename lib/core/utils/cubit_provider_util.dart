import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/features.dart';
import '../core.dart';

final cubitProviderUtil = [
  BlocProvider<PokemonCubit>(create: (context) => sl<PokemonCubit>()),
  // FavoriteCubit removed; use PokemonCubit for favorites logic
];
