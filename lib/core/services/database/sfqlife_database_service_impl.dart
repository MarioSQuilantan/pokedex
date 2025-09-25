import 'package:injectable/injectable.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../core.dart';

@LazySingleton(as: DatabaseService)
class SqfliteDatabaseServiceImpl implements DatabaseService {
  Database database;

  SqfliteDatabaseServiceImpl(this.database);

  @override
  Future<dynamic> insert(String table, Map<String, dynamic> data) async => database.insert(table, data);

  @override
  Future<dynamic> deleteById(String table, int id) async => await database.delete(table, where: 'id = $id');

  @override
  Future<dynamic> get(String table) async => database.query(table);
}
