class InsertFavoritePokemonRequest {
  final String name;
  final String imagePath;
  final int id;

  InsertFavoritePokemonRequest({required this.id, required this.name, required this.imagePath});

  Map<String, dynamic> toJson() => {"name": name, "imagePath": imagePath, "id": id};
}
