import 'dart:ui';

import '../../domain/domain.dart';

class PokemonDetailApiModel {
  PokemonDetailApiModel({
    required this.abilities,
    required this.baseExperience,
    required this.cries,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastAbilities,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
    required this.description,
  });

  final List<PokemonDetailAbilityModel> abilities;
  final num baseExperience;
  final PokemonDetailCriesModel? cries;
  final List<PokemonDetailSpeciesModel> forms;
  final List<PokemonDetailGameIndexModel> gameIndices;
  final num height;
  final List<PokemonDetailHeldItemModel> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<PokemonDetailMoveModel> moves;
  final String name;
  final num order;
  final List<PokemonDetailPastAbilityModel> pastAbilities;
  final List<dynamic> pastTypes;
  final PokemonDetailSpeciesModel? species;
  final PokemonDetailSpritesModel? sprites;
  final List<PokemonDetailStatModel> stats;
  final List<PokemonDetailTypeModel> types;
  final num weight;
  final String? description;

  factory PokemonDetailApiModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailApiModel(
      abilities: json["abilities"] == null
          ? []
          : List<PokemonDetailAbilityModel>.from(json["abilities"]!.map((x) => PokemonDetailAbilityModel.fromJson(x))),
      baseExperience: json["base_experience"] ?? 0,
      cries: json["cries"] == null ? null : PokemonDetailCriesModel.fromJson(json["cries"]),
      forms: json["forms"] == null
          ? []
          : List<PokemonDetailSpeciesModel>.from(json["forms"]!.map((x) => PokemonDetailSpeciesModel.fromJson(x))),
      gameIndices: json["game_indices"] == null
          ? []
          : List<PokemonDetailGameIndexModel>.from(
              json["game_indices"]!.map((x) => PokemonDetailGameIndexModel.fromJson(x)),
            ),
      height: json["height"] ?? 0,
      heldItems: json["held_items"] == null
          ? []
          : List<PokemonDetailHeldItemModel>.from(
              json["held_items"]!.map((x) => PokemonDetailHeldItemModel.fromJson(x)),
            ),
      id: json["id"] ?? 0,
      isDefault: json["is_default"] ?? false,
      locationAreaEncounters: json["location_area_encounters"] ?? "",
      moves: json["moves"] == null
          ? []
          : List<PokemonDetailMoveModel>.from(json["moves"]!.map((x) => PokemonDetailMoveModel.fromJson(x))),
      name: json["name"] ?? "",
      order: json["order"] ?? 0,
      pastAbilities: json["past_abilities"] == null
          ? []
          : List<PokemonDetailPastAbilityModel>.from(
              json["past_abilities"]!.map((x) => PokemonDetailPastAbilityModel.fromJson(x)),
            ),
      pastTypes: json["past_types"] == null ? [] : List<dynamic>.from(json["past_types"]!.map((x) => x)),
      species: json["species"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["species"]),
      sprites: json["sprites"] == null ? null : PokemonDetailSpritesModel.fromJson(json["sprites"]),
      stats: json["stats"] == null
          ? []
          : List<PokemonDetailStatModel>.from(json["stats"]!.map((x) => PokemonDetailStatModel.fromJson(x))),
      types: json["types"] == null
          ? []
          : List<PokemonDetailTypeModel>.from(json["types"]!.map((x) => PokemonDetailTypeModel.fromJson(x))),
      weight: json["weight"] ?? 0,
      description: json["description"] ?? 'Description No disponible',
    );
  }
}

class PokemonDetailAbilityModel {
  PokemonDetailAbilityModel({required this.ability, required this.isHidden, required this.slot});

  final PokemonDetailSpeciesModel? ability;
  final bool isHidden;
  final num slot;

  factory PokemonDetailAbilityModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailAbilityModel(
      ability: json["ability"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["ability"]),
      isHidden: json["is_hidden"] ?? false,
      slot: json["slot"] ?? 0,
    );
  }
}

class PokemonDetailSpeciesModel {
  PokemonDetailSpeciesModel({required this.name, required this.url});

  final String name;
  final String url;

  factory PokemonDetailSpeciesModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailSpeciesModel(name: json["name"] ?? "", url: json["url"] ?? "");
  }
}

class PokemonDetailCriesModel {
  PokemonDetailCriesModel({required this.latest, required this.legacy});

  final String latest;
  final String legacy;

  factory PokemonDetailCriesModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailCriesModel(latest: json["latest"] ?? "", legacy: json["legacy"] ?? "");
  }
}

class PokemonDetailGameIndexModel {
  PokemonDetailGameIndexModel({required this.gameIndex, required this.version});

  final num gameIndex;
  final PokemonDetailSpeciesModel? version;

  factory PokemonDetailGameIndexModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGameIndexModel(
      gameIndex: json["game_index"] ?? 0,
      version: json["version"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["version"]),
    );
  }
}

class PokemonDetailHeldItemModel {
  PokemonDetailHeldItemModel({required this.item, required this.versionDetails});

  final PokemonDetailSpeciesModel? item;
  final List<PokemonDetailVersionDetailModel> versionDetails;

  factory PokemonDetailHeldItemModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailHeldItemModel(
      item: json["item"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["item"]),
      versionDetails: json["version_details"] == null
          ? []
          : List<PokemonDetailVersionDetailModel>.from(
              json["version_details"]!.map((x) => PokemonDetailVersionDetailModel.fromJson(x)),
            ),
    );
  }
}

class PokemonDetailVersionDetailModel {
  PokemonDetailVersionDetailModel({required this.rarity, required this.version});

  final num rarity;
  final PokemonDetailSpeciesModel? version;

  factory PokemonDetailVersionDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailVersionDetailModel(
      rarity: json["rarity"] ?? 0,
      version: json["version"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["version"]),
    );
  }
}

class PokemonDetailMoveModel {
  PokemonDetailMoveModel({required this.move, required this.versionGroupDetails});

  final PokemonDetailSpeciesModel? move;
  final List<PokemonDetailVersionGroupDetailModel> versionGroupDetails;

  factory PokemonDetailMoveModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailMoveModel(
      move: json["move"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["move"]),
      versionGroupDetails: json["version_group_details"] == null
          ? []
          : List<PokemonDetailVersionGroupDetailModel>.from(
              json["version_group_details"]!.map((x) => PokemonDetailVersionGroupDetailModel.fromJson(x)),
            ),
    );
  }
}

class PokemonDetailVersionGroupDetailModel {
  PokemonDetailVersionGroupDetailModel({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.order,
    required this.versionGroup,
  });

  final num levelLearnedAt;
  final PokemonDetailSpeciesModel? moveLearnMethod;
  final dynamic order;
  final PokemonDetailSpeciesModel? versionGroup;

  factory PokemonDetailVersionGroupDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailVersionGroupDetailModel(
      levelLearnedAt: json["level_learned_at"] ?? 0,
      moveLearnMethod: json["move_learn_method"] == null
          ? null
          : PokemonDetailSpeciesModel.fromJson(json["move_learn_method"]),
      order: json["order"],
      versionGroup: json["version_group"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["version_group"]),
    );
  }
}

class PokemonDetailPastAbilityModel {
  PokemonDetailPastAbilityModel({required this.abilities, required this.generation});

  final List<PokemonDetailAbilityModel> abilities;
  final PokemonDetailSpeciesModel? generation;

  factory PokemonDetailPastAbilityModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailPastAbilityModel(
      abilities: json["abilities"] == null
          ? []
          : List<PokemonDetailAbilityModel>.from(json["abilities"]!.map((x) => PokemonDetailAbilityModel.fromJson(x))),
      generation: json["generation"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["generation"]),
    );
  }
}

class PokemonDetailGenerationVModel {
  PokemonDetailGenerationVModel({required this.blackWhite});

  final PokemonDetailSpritesModel? blackWhite;

  factory PokemonDetailGenerationVModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationVModel(
      blackWhite: json["black-white"] == null ? null : PokemonDetailSpritesModel.fromJson(json["black-white"]),
    );
  }
}

class PokemonDetailGenerationIvModel {
  PokemonDetailGenerationIvModel({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  final PokemonDetailSpritesModel? diamondPearl;
  final PokemonDetailSpritesModel? heartgoldSoulsilver;
  final PokemonDetailSpritesModel? platinum;

  factory PokemonDetailGenerationIvModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationIvModel(
      diamondPearl: json["diamond-pearl"] == null ? null : PokemonDetailSpritesModel.fromJson(json["diamond-pearl"]),
      heartgoldSoulsilver: json["heartgold-soulsilver"] == null
          ? null
          : PokemonDetailSpritesModel.fromJson(json["heartgold-soulsilver"]),
      platinum: json["platinum"] == null ? null : PokemonDetailSpritesModel.fromJson(json["platinum"]),
    );
  }
}

class PokemonDetailVersionsModel {
  PokemonDetailVersionsModel({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  final PokemonDetailGenerationIModel? generationI;
  final PokemonDetailGenerationIiModel? generationIi;
  final PokemonDetailGenerationIiiModel? generationIii;
  final PokemonDetailGenerationIvModel? generationIv;
  final PokemonDetailGenerationVModel? generationV;
  final Map<String, PokemonDetailHomeModel> generationVi;
  final PokemonDetailGenerationViiModel? generationVii;
  final PokemonDetailGenerationViiiModel? generationViii;

  factory PokemonDetailVersionsModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailVersionsModel(
      generationI: json["generation-i"] == null ? null : PokemonDetailGenerationIModel.fromJson(json["generation-i"]),
      generationIi: json["generation-ii"] == null
          ? null
          : PokemonDetailGenerationIiModel.fromJson(json["generation-ii"]),
      generationIii: json["generation-iii"] == null
          ? null
          : PokemonDetailGenerationIiiModel.fromJson(json["generation-iii"]),
      generationIv: json["generation-iv"] == null
          ? null
          : PokemonDetailGenerationIvModel.fromJson(json["generation-iv"]),
      generationV: json["generation-v"] == null ? null : PokemonDetailGenerationVModel.fromJson(json["generation-v"]),
      generationVi: Map.from(
        json["generation-vi"],
      ).map((k, v) => MapEntry<String, PokemonDetailHomeModel>(k, PokemonDetailHomeModel.fromJson(v))),
      generationVii: json["generation-vii"] == null
          ? null
          : PokemonDetailGenerationViiModel.fromJson(json["generation-vii"]),
      generationViii: json["generation-viii"] == null
          ? null
          : PokemonDetailGenerationViiiModel.fromJson(json["generation-viii"]),
    );
  }
}

class PokemonDetailOtherModel {
  PokemonDetailOtherModel({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
    required this.showdown,
  });

  final PokemonDetailDreamWorldModel? dreamWorld;
  final PokemonDetailHomeModel? home;
  final PokemonDetailOfficialArtworkModel? officialArtwork;
  final PokemonDetailSpritesModel? showdown;

  factory PokemonDetailOtherModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailOtherModel(
      dreamWorld: json["dream_world"] == null ? null : PokemonDetailDreamWorldModel.fromJson(json["dream_world"]),
      home: json["home"] == null ? null : PokemonDetailHomeModel.fromJson(json["home"]),
      officialArtwork: json["official-artwork"] == null
          ? null
          : PokemonDetailOfficialArtworkModel.fromJson(json["official-artwork"]),
      showdown: json["showdown"] == null ? null : PokemonDetailSpritesModel.fromJson(json["showdown"]),
    );
  }
}

class PokemonDetailSpritesModel {
  PokemonDetailSpritesModel({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    required this.other,
    required this.versions,
    required this.animated,
  });

  final String backDefault;
  final dynamic backFemale;
  final String backShiny;
  final dynamic backShinyFemale;
  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;
  final PokemonDetailOtherModel? other;
  final PokemonDetailVersionsModel? versions;
  final PokemonDetailSpritesModel? animated;

  factory PokemonDetailSpritesModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailSpritesModel(
      backDefault: json["back_default"] ?? "",
      backFemale: json["back_female"],
      backShiny: json["back_shiny"] ?? "",
      backShinyFemale: json["back_shiny_female"],
      frontDefault: json["front_default"] ?? "",
      frontFemale: json["front_female"],
      frontShiny: json["front_shiny"] ?? "",
      frontShinyFemale: json["front_shiny_female"],
      other: json["other"] == null ? null : PokemonDetailOtherModel.fromJson(json["other"]),
      versions: json["versions"] == null ? null : PokemonDetailVersionsModel.fromJson(json["versions"]),
      animated: json["animated"] == null ? null : PokemonDetailSpritesModel.fromJson(json["animated"]),
    );
  }
}

class PokemonDetailGenerationIModel {
  PokemonDetailGenerationIModel({required this.redBlue, required this.yellow});

  final PokemonDetailRedBlueModel? redBlue;
  final PokemonDetailRedBlueModel? yellow;

  factory PokemonDetailGenerationIModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationIModel(
      redBlue: json["red-blue"] == null ? null : PokemonDetailRedBlueModel.fromJson(json["red-blue"]),
      yellow: json["yellow"] == null ? null : PokemonDetailRedBlueModel.fromJson(json["yellow"]),
    );
  }
}

class PokemonDetailRedBlueModel {
  PokemonDetailRedBlueModel({
    required this.backDefault,
    required this.backGray,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontGray,
    required this.frontTransparent,
  });

  final String backDefault;
  final String backGray;
  final String backTransparent;
  final String frontDefault;
  final String frontGray;
  final String frontTransparent;

  factory PokemonDetailRedBlueModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailRedBlueModel(
      backDefault: json["back_default"] ?? "",
      backGray: json["back_gray"] ?? "",
      backTransparent: json["back_transparent"] ?? "",
      frontDefault: json["front_default"] ?? "",
      frontGray: json["front_gray"] ?? "",
      frontTransparent: json["front_transparent"] ?? "",
    );
  }
}

class PokemonDetailGenerationIiModel {
  PokemonDetailGenerationIiModel({required this.crystal, required this.gold, required this.silver});

  final PokemonDetailCrystalModel? crystal;
  final PokemonDetailGoldModel? gold;
  final PokemonDetailGoldModel? silver;

  factory PokemonDetailGenerationIiModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationIiModel(
      crystal: json["crystal"] == null ? null : PokemonDetailCrystalModel.fromJson(json["crystal"]),
      gold: json["gold"] == null ? null : PokemonDetailGoldModel.fromJson(json["gold"]),
      silver: json["silver"] == null ? null : PokemonDetailGoldModel.fromJson(json["silver"]),
    );
  }
}

class PokemonDetailCrystalModel {
  PokemonDetailCrystalModel({
    required this.backDefault,
    required this.backShiny,
    required this.backShinyTransparent,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontShinyTransparent,
    required this.frontTransparent,
  });

  final String backDefault;
  final String backShiny;
  final String backShinyTransparent;
  final String backTransparent;
  final String frontDefault;
  final String frontShiny;
  final String frontShinyTransparent;
  final String frontTransparent;

  factory PokemonDetailCrystalModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailCrystalModel(
      backDefault: json["back_default"] ?? "",
      backShiny: json["back_shiny"] ?? "",
      backShinyTransparent: json["back_shiny_transparent"] ?? "",
      backTransparent: json["back_transparent"] ?? "",
      frontDefault: json["front_default"] ?? "",
      frontShiny: json["front_shiny"] ?? "",
      frontShinyTransparent: json["front_shiny_transparent"] ?? "",
      frontTransparent: json["front_transparent"] ?? "",
    );
  }
}

class PokemonDetailGoldModel {
  PokemonDetailGoldModel({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontTransparent,
  });

  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;
  final String frontTransparent;

  factory PokemonDetailGoldModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGoldModel(
      backDefault: json["back_default"] ?? "",
      backShiny: json["back_shiny"] ?? "",
      frontDefault: json["front_default"] ?? "",
      frontShiny: json["front_shiny"] ?? "",
      frontTransparent: json["front_transparent"] ?? "",
    );
  }
}

class PokemonDetailGenerationIiiModel {
  PokemonDetailGenerationIiiModel({required this.emerald, required this.fireredLeafgreen, required this.rubySapphire});

  final PokemonDetailOfficialArtworkModel? emerald;
  final PokemonDetailGoldModel? fireredLeafgreen;
  final PokemonDetailGoldModel? rubySapphire;

  factory PokemonDetailGenerationIiiModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationIiiModel(
      emerald: json["emerald"] == null ? null : PokemonDetailOfficialArtworkModel.fromJson(json["emerald"]),
      fireredLeafgreen: json["firered-leafgreen"] == null
          ? null
          : PokemonDetailGoldModel.fromJson(json["firered-leafgreen"]),
      rubySapphire: json["ruby-sapphire"] == null ? null : PokemonDetailGoldModel.fromJson(json["ruby-sapphire"]),
    );
  }
}

class PokemonDetailOfficialArtworkModel {
  PokemonDetailOfficialArtworkModel({required this.frontDefault, required this.frontShiny});

  final String frontDefault;
  final String frontShiny;

  factory PokemonDetailOfficialArtworkModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailOfficialArtworkModel(
      frontDefault: json["front_default"] ?? "",
      frontShiny: json["front_shiny"] ?? "",
    );
  }
}

class PokemonDetailHomeModel {
  PokemonDetailHomeModel({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  final String frontDefault;
  final dynamic frontFemale;
  final String frontShiny;
  final dynamic frontShinyFemale;

  factory PokemonDetailHomeModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailHomeModel(
      frontDefault: json["front_default"] ?? "",
      frontFemale: json["front_female"],
      frontShiny: json["front_shiny"] ?? "",
      frontShinyFemale: json["front_shiny_female"],
    );
  }
}

class PokemonDetailGenerationViiModel {
  PokemonDetailGenerationViiModel({required this.icons, required this.ultraSunUltraMoon});

  final PokemonDetailDreamWorldModel? icons;
  final PokemonDetailHomeModel? ultraSunUltraMoon;

  factory PokemonDetailGenerationViiModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationViiModel(
      icons: json["icons"] == null ? null : PokemonDetailDreamWorldModel.fromJson(json["icons"]),
      ultraSunUltraMoon: json["ultra-sun-ultra-moon"] == null
          ? null
          : PokemonDetailHomeModel.fromJson(json["ultra-sun-ultra-moon"]),
    );
  }
}

class PokemonDetailDreamWorldModel {
  PokemonDetailDreamWorldModel({required this.frontDefault, required this.frontFemale});

  final String frontDefault;
  final dynamic frontFemale;

  factory PokemonDetailDreamWorldModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailDreamWorldModel(frontDefault: json["front_default"] ?? "", frontFemale: json["front_female"]);
  }
}

class PokemonDetailGenerationViiiModel {
  PokemonDetailGenerationViiiModel({required this.icons});

  final PokemonDetailDreamWorldModel? icons;

  factory PokemonDetailGenerationViiiModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailGenerationViiiModel(
      icons: json["icons"] == null ? null : PokemonDetailDreamWorldModel.fromJson(json["icons"]),
    );
  }
}

class PokemonDetailStatModel {
  PokemonDetailStatModel({required this.baseStat, required this.effort, required this.stat});

  final num baseStat;
  final num effort;
  final PokemonDetailSpeciesModel? stat;

  factory PokemonDetailStatModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailStatModel(
      baseStat: json["base_stat"] ?? 0,
      effort: json["effort"] ?? 0,
      stat: json["stat"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["stat"]),
    );
  }
}

class PokemonDetailTypeModel {
  PokemonDetailTypeModel({required this.slot, required this.type});

  final num slot;
  final PokemonDetailSpeciesModel? type;

  factory PokemonDetailTypeModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailTypeModel(
      slot: json["slot"] ?? 0,
      type: json["type"] == null ? null : PokemonDetailSpeciesModel.fromJson(json["type"]),
    );
  }
}

extension PokemonDetailModelMapper on PokemonDetailApiModel {
  PokemonDetailEntity toEntity() {
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    return PokemonDetailEntity(
      id: id,
      name: name,
      height: height,
      weight: weight,
      imageUrl: imageUrl,
      background: _colorFor(types[0].type?.name ?? ''),
      types: types.toEntityList(),
      abilities: abilities.map((a) => a.ability?.name ?? '').toList(),
      baseExperience: baseExperience,
      stats: stats.map((s) => s.baseStat).toList(),
    );
  }
}

extension PokemonDetailTypeMapper on List<PokemonDetailTypeModel> {
  PokemonDetailTypesEntity _toEntity(String type, Color background) {
    return PokemonDetailTypesEntity(type: type, background: background);
  }

  List<PokemonDetailTypesEntity> toEntityList() {
    return map((t) {
      final typeName = t.type?.name ?? '';
      final color = _colorFor(typeName);
      return _toEntity(typeName, color);
    }).toList();
  }
}

Color _colorFor(String t) {
  switch (t.toLowerCase()) {
    case 'normal':
      return const Color(0xFFA8A77A);
    case 'fire':
      return const Color(0xFFEE8130);
    case 'water':
      return const Color(0xFF6390F0);
    case 'electric':
      return const Color(0xFFF7D02C);
    case 'grass':
      return const Color(0xFF7AC74C);
    case 'ice':
      return const Color(0xFF96D9D6);
    case 'fighting':
      return const Color(0xFFC22E28);
    case 'poison':
      return const Color(0xFFA33EA1);
    case 'ground':
      return const Color(0xFFE2BF65);
    case 'flying':
      return const Color(0xFFA98FF3);
    case 'psychic':
      return const Color(0xFFF95587);
    case 'bug':
      return const Color(0xFFA6B91A);
    case 'rock':
      return const Color(0xFFB6A136);
    case 'ghost':
      return const Color(0xFF735797);
    case 'dragon':
      return const Color(0xFF6F35FC);
    case 'dark':
      return const Color(0xFF705746);
    case 'steel':
      return const Color(0xFFB7B7CE);
    case 'fairy':
      return const Color(0xFFD685AD);
    default:
      return const Color(0xFF777777);
  }
}
