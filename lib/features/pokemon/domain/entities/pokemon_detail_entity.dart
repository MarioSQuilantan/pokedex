import 'dart:ui';

class PokemonDetailEntity {
  final num id;
  final String name;
  final num height;
  final num weight;
  final String imageUrl;
  final Color background;
  final List<PokemonDetailTypesEntity> types;
  final List<String> abilities;
  final num baseExperience;
  final List<num> stats;

  const PokemonDetailEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.background,
    required this.types,
    required this.abilities,
    required this.baseExperience,
    required this.stats,
  });
}

class PokemonDetailTypesEntity {
  final String type;
  final Color background;

  PokemonDetailTypesEntity({required this.type, required this.background});
}
