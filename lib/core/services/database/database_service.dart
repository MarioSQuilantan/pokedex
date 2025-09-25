abstract interface class DatabaseService {
  Future<dynamic> get(String table);

  Future<dynamic> deleteById(String table, int id);

  Future<dynamic> insert(String table, Map<String, dynamic> data);
}
