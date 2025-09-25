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
    final cubit = context.read<PokemonCubit>();
    _isFavorite = cubit.isPokemonFavorite(widget.id);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!cubit.hasLoadedFavorites) cubit.loadFavoritesSilently();
    });
  }

  Future<void> _onPressed() async {
    final cubit = context.read<PokemonCubit>();
    final scaffold = ScaffoldMessenger.of(context);

    // optimistic update
    setState(() => _isFavorite = !(_isFavorite ?? false));

    try {
      if (_isFavorite == true) {
        await cubit.onAddPokemonToFavorites(id: widget.id);
        widget.onFavoriteChanged?.call();
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('Pokémon agregado a favoritos'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        await cubit.onRemovePokemonFromFavorites(pokemonId: widget.id);
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
      // rollback on error
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
    return BlocListener<PokemonCubit, PokemonState>(
      listener: (context, state) {
        // sync local optimistic state with cubit changes
        final cubit = context.read<PokemonCubit>();
        final fav = cubit.isPokemonFavorite(widget.id);
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
