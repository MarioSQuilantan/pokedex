import '../../domain/domain.dart';

class PokemonListDataBaseModel {
  final String name;
  final int id;
  final String imagePath;

  PokemonListDataBaseModel({required this.name, required this.id, required this.imagePath});

  factory PokemonListDataBaseModel.fromJson(Map<String, dynamic> json) {
    return PokemonListDataBaseModel(name: json['name'], id: json['id'], imagePath: json['imagePath']);
  }

  static List<PokemonListDataBaseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PokemonListDataBaseModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}

extension PokemonListModelDataBaseMapper on List<PokemonListDataBaseModel> {
  List<PokemonEntity> toEntityList() {
    return map((dto) => PokemonEntity(name: dto.name, id: dto.id, imagePath: dto.imagePath)).toList();
  }
}
