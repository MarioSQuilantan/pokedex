import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     FavoriteButtonWidget(
            //       id: pokemon.id,
            //       updateFavoriteList: updateFavoriteList,
            //       onFavoriteChanged: onFavoriteChanged,
            //     ),
            //   ],
            // ),
            CachedNetworkImage(
              imageUrl: pokemon.imagePath,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error, size: 64, color: Colors.red)),
            ),
            Text(pokemonIdFormatterUtil(pokemon.id), style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(pokemon.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
