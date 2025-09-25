enum RoutePathsEnum {
  pokemonList('/pokemon-list', 'pokemon-list'),
  favoritePokemonList('/favorite-pokemon-list', 'favorite-pokemon-list'),
  pokemonDetail('/pokemon-detail/:id', 'pokemon-detail');

  final String path;
  final String name;

  const RoutePathsEnum(this.path, this.name);
}
