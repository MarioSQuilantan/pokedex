import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../core.dart';

@LazySingleton(as: DatabaseService)
class SqfliteDatabaseServiceImpl implements DatabaseService {
  Database database;

  SqfliteDatabaseServiceImpl(this.database);

  @override
  TaskEither<DbException, T> insert<T>(String table, Map<String, dynamic> data) => TaskEither.tryCatch(
    () async => await database.insert(table, data) as T,
    (error, _) => DbException(message: 'Insert failed: ${error.toString()}'),
  );

  @override
  TaskEither<DbException, T> deleteById<T>(String table, int id) => TaskEither.tryCatch(
    () async => await database.delete(table, where: 'id = ?', whereArgs: [id]) as T,
    (error, _) => DbException(message: 'Delete failed: ${error.toString()}'),
  );

  @override
  TaskEither<DbException, T> get<T>(String table) => TaskEither.tryCatch(
    () async => await database.query(table) as T,
    (error, _) => DbException(message: 'Query failed: ${error.toString()}'),
  );
}
