import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../features.dart';
// ...existing code...

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({
    super.key,
    required this.pokemon,
    required this.onTap,
    this.updateFavoriteList = false,
    this.onFavoriteChanged,
  });

  final PokemonEntity pokemon;
  final Function() onTap;
  final bool updateFavoriteList;
  final VoidCallback? onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FavoriteButtonWidget(
                  id: pokemon.id,
                  updateFavoriteList: updateFavoriteList,
                  onFavoriteChanged: onFavoriteChanged,
                ),
              ],
            ),
            Image.network(
              pokemon.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error, size: 64, color: Colors.red));
              },
            ),
            Text(pokemonIdFormatterUtil(pokemon.id), style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(pokemon.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
