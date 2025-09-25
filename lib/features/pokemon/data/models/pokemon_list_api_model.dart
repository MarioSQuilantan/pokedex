import '../../domain/domain.dart';

class PokemonListApiModel {
  final String name;
  final String url;

  PokemonListApiModel({required this.name, required this.url});

  factory PokemonListApiModel.fromJson(Map<String, dynamic> json) {
    return PokemonListApiModel(name: json['name'], url: json['url']);
  }

  static List<PokemonListApiModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PokemonListApiModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}

extension PokemonListApiModelMapper on PokemonListApiModel {
  PokemonEntity toEntity() {
    final uri = Uri.parse(url);
    final id = int.tryParse(uri.pathSegments[uri.pathSegments.length - 2]) ?? 0;
    final imagePath = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    return PokemonEntity(name: name, id: id, imagePath: imagePath);
  }
}
