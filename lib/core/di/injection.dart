import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../core.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => sl.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<Database> get database async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'app_database.db');

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int _) async {
        await db.execute('''
          CREATE TABLE favoritePokemon (
            id INTEGER PRIMARY KEY,
            imagePath TEXT NOT NULL,
            name TEXT NOT NULL
          )
        ''');
      },
    );

    return database;
  }

  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: DevEnv.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    return dio;
  }
}
