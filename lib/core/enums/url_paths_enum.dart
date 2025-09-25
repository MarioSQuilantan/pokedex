enum UrlPathsEnum {
  getPokemonList('/pokemon'),
  getPokemonDetailById('/pokemon/');

  final String path;

  const UrlPathsEnum(this.path);
}
