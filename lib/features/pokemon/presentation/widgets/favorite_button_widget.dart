import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';

class FavoriteButtonWidget extends StatefulWidget {
  final int id;
  final bool updateFavoriteList;
  final VoidCallback? onFavoriteChanged;

  const FavoriteButtonWidget({super.key, required this.id, this.updateFavoriteList = false, this.onFavoriteChanged});

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  bool? _isFavorite;

  @override
  void initState() {
    super.initState();
    final favCubit = context.read<PokemonFavoriteCubit>();
    _isFavorite = favCubit.isPokemonFavorite(widget.id);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!favCubit.hasLoadedFavorites) favCubit.loadFavoritesSilently();
    });
  }

  Future<void> _onPressed() async {
    final favCubit = context.read<PokemonFavoriteCubit>();
    final listCubit = context.read<PokemonListCubit>();
    final scaffold = ScaffoldMessenger.of(context);

    setState(() => _isFavorite = !(_isFavorite ?? false));

    try {
      if (_isFavorite == true) {
        final pokemon = listCubit.state is PokemonItemsLoaded
            ? (listCubit.state as PokemonItemsLoaded).items.firstWhere(
                (p) => p.id == widget.id,
                orElse: () => throw Exception('Pokémon no encontrado'),
              )
            : throw Exception('Lista no cargada');

        await favCubit.addPokemonToFavorites(pokemon);
        widget.onFavoriteChanged?.call();
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('Pokémon agregado a favoritos'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        await favCubit.removePokemonFromFavorites(widget.id);
        widget.onFavoriteChanged?.call();
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('Pokémon eliminado de favoritos'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() => _isFavorite = !(_isFavorite ?? false));
      scaffold.showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonFavoriteCubit, PokemonFavoriteState>(
      listener: (context, state) {
        final favCubit = context.read<PokemonFavoriteCubit>();
        final fav = favCubit.isPokemonFavorite(widget.id);
        if (mounted && fav != _isFavorite) {
          setState(() => _isFavorite = fav);
        }
      },
      child: IconButton(
        onPressed: _onPressed,
        icon: Icon(
          (_isFavorite ?? false) ? Icons.favorite : Icons.favorite_border,
          color: (_isFavorite ?? false) ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
