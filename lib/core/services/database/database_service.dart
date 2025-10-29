import 'package:fpdart/fpdart.dart';

import '../../core.dart';

abstract interface class DatabaseService {
  TaskEither<DbException, T> get<T>(String table);

  TaskEither<DbException, T> deleteById<T>(String table, int id);

  TaskEither<DbException, T> insert<T>(String table, Map<String, dynamic> data);
}
