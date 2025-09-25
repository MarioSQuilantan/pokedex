import 'package:go_router/go_router.dart';

import '../../features/features.dart';

GoRouter appRouter = GoRouter(
  initialLocation: PokemonListScreen.path,

  routes: [
    GoRoute(path: PokemonListScreen.path, name: PokemonListScreen.name, builder: (_, __) => const PokemonListScreen()),
    GoRoute(
      path: FavoritePokemonListScreen.path,
      name: FavoritePokemonListScreen.name,
      builder: (_, __) => const FavoritePokemonListScreen(),
    ),
    GoRoute(
      path: PokemonDetailScreen.path,
      name: PokemonDetailScreen.name,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PokemonDetailScreen(pokemonId: id);
      },
    ),
  ],
);
