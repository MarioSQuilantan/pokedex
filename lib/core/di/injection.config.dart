// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pokedex/core/core.dart' as _i558;
import 'package:pokedex/core/di/injection.dart' as _i526;
import 'package:pokedex/core/services/database/sfqlife_database_service_impl.dart'
    as _i524;
import 'package:pokedex/core/services/network/dio_network_service_impl.dart'
    as _i368;
import 'package:pokedex/features/pokemon/application/application.dart' as _i737;
import 'package:pokedex/features/pokemon/application/cubit/pokemon_detail_cubit.dart'
    as _i522;
import 'package:pokedex/features/pokemon/application/cubit/pokemon_favorite_cubit.dart'
    as _i354;
import 'package:pokedex/features/pokemon/application/cubit/pokemon_list_cubit.dart'
    as _i270;
import 'package:pokedex/features/pokemon/application/use_cases/delete_favorite_pokemon_use_case.dart'
    as _i827;
import 'package:pokedex/features/pokemon/application/use_cases/get_favorite_pokemon_list_use_case.dart'
    as _i969;
import 'package:pokedex/features/pokemon/application/use_cases/get_pokemon_detail_by_id_use_case.dart'
    as _i283;
import 'package:pokedex/features/pokemon/application/use_cases/get_pokemon_list_use_case.dart'
    as _i428;
import 'package:pokedex/features/pokemon/application/use_cases/insert_favorite_pokemon_use_case.dart'
    as _i905;
import 'package:pokedex/features/pokemon/data/data.dart' as _i870;
import 'package:pokedex/features/pokemon/data/data_sources/pokemon_data_source_impl.dart'
    as _i215;
import 'package:pokedex/features/pokemon/data/repository_impl/pokemon_repository_impl.dart'
    as _i665;
import 'package:pokedex/features/pokemon/domain/domain.dart' as _i1060;
import 'package:sqflite/sqflite.dart' as _i779;
import 'package:sqflite/sqlite_api.dart' as _i232;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i779.Database>(
      () => registerModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.NetworkService>(
      () => _i368.DioNetworkServiceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i558.DatabaseService>(
      () => _i524.SqfliteDatabaseServiceImpl(gh<_i232.Database>()),
    );
    gh.lazySingleton<_i870.PokemonDataSource>(
      () => _i215.PokemonRemoteDataSourceImpl(
        gh<_i558.NetworkService>(),
        gh<_i558.DatabaseService>(),
      ),
    );
    gh.lazySingleton<_i1060.PokemonRepository>(
      () => _i665.PokemonRepositoryImpl(gh<_i870.PokemonDataSource>()),
    );
    gh.lazySingleton<_i283.GetPokemonDetailUseCase>(
      () => _i283.GetPokemonDetailUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i428.GetPokemonListUseCase>(
      () => _i428.GetPokemonListUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i827.DeleteFavoritePokemonUseCase>(
      () => _i827.DeleteFavoritePokemonUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i905.InsertFavoritePokemonUseCase>(
      () => _i905.InsertFavoritePokemonUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i969.GetFavoritePokemonListUseCase>(
      () => _i969.GetFavoritePokemonListUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i270.PokemonListCubit>(
      () => _i270.PokemonListCubit(gh<_i737.GetPokemonListUseCase>()),
    );
    gh.lazySingleton<_i354.PokemonFavoriteCubit>(
      () => _i354.PokemonFavoriteCubit(
        gh<_i737.GetFavoritePokemonListUseCase>(),
        gh<_i737.InsertFavoritePokemonUseCase>(),
        gh<_i737.DeleteFavoritePokemonUseCase>(),
      ),
    );
    gh.lazySingleton<_i522.PokemonDetailCubit>(
      () => _i522.PokemonDetailCubit(gh<_i737.GetPokemonDetailUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i526.RegisterModule {}
