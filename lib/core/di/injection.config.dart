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
import 'package:pokedex/features/features.dart' as _i652;
import 'package:pokedex/features/pokemon/data/data.dart' as _i870;
import 'package:pokedex/features/pokemon/data/data_sources/api/pokemon_api_data_source_impl.dart'
    as _i521;
import 'package:pokedex/features/pokemon/data/data_sources/database/pokemon_database_data_source_impl.dart'
    as _i60;
import 'package:pokedex/features/pokemon/data/repository_impl/pokemon_repository_impl.dart'
    as _i665;
import 'package:pokedex/features/pokemon/domain/domain.dart' as _i1060;
import 'package:pokedex/features/pokemon/domain/use_cases/delete_favorite_pokemon_use_case.dart'
    as _i902;
import 'package:pokedex/features/pokemon/domain/use_cases/get_favorite_pokemon_list_use_case.dart'
    as _i830;
import 'package:pokedex/features/pokemon/domain/use_cases/get_pokemon_detail_by_id_use_case.dart'
    as _i213;
import 'package:pokedex/features/pokemon/domain/use_cases/get_pokemon_list_use_case.dart'
    as _i287;
import 'package:pokedex/features/pokemon/domain/use_cases/insert_favorite_pokemon_use_case.dart'
    as _i425;
import 'package:pokedex/features/pokemon/presentation/blocs/delete_favorite_pokemon/delete_favorite_pokemon_bloc.dart'
    as _i1022;
import 'package:pokedex/features/pokemon/presentation/blocs/get_favorite_pokemon_list/get_favorite_pokemon_list_bloc.dart'
    as _i225;
import 'package:pokedex/features/pokemon/presentation/blocs/get_pokemon_detail_by_id/get_pokemon_detail_by_id_bloc.dart'
    as _i702;
import 'package:pokedex/features/pokemon/presentation/blocs/get_pokemon_list/get_pokemon_list_bloc.dart'
    as _i1001;
import 'package:pokedex/features/pokemon/presentation/blocs/insert_favorite_pokemon/insert_favorite_pokemon_bloc.dart'
    as _i370;
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
    gh.lazySingleton<_i870.PokemonApiDataSource>(
      () => _i521.PokemonApiRemoteDataSourceImpl(gh<_i558.NetworkService>()),
    );
    gh.lazySingleton<_i870.PokemonDatabaseDataSource>(
      () =>
          _i60.PokemonDatabaseRemoteDataSourceImpl(gh<_i558.DatabaseService>()),
    );
    gh.lazySingleton<_i1060.PokemonRepository>(
      () => _i665.PokemonRepositoryImpl(
        gh<_i870.PokemonApiDataSource>(),
        gh<_i870.PokemonDatabaseDataSource>(),
      ),
    );
    gh.lazySingleton<_i213.GetPokemonDetailUseCase>(
      () => _i213.GetPokemonDetailUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i902.DeleteFavoritePokemonUseCase>(
      () => _i902.DeleteFavoritePokemonUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i287.GetPokemonListUseCase>(
      () => _i287.GetPokemonListUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i425.InsertFavoritePokemonUseCase>(
      () => _i425.InsertFavoritePokemonUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.lazySingleton<_i830.GetFavoritePokemonListUseCase>(
      () => _i830.GetFavoritePokemonListUseCase(gh<_i1060.PokemonRepository>()),
    );
    gh.factory<_i1001.GetPokemonListBloc>(
      () => _i1001.GetPokemonListBloc(gh<_i652.GetPokemonListUseCase>()),
    );
    gh.factory<_i370.InsertFavoritePokemonBloc>(
      () => _i370.InsertFavoritePokemonBloc(
        gh<_i652.InsertFavoritePokemonUseCase>(),
      ),
    );
    gh.factory<_i1022.DeleteFavoritePokemonBloc>(
      () => _i1022.DeleteFavoritePokemonBloc(
        gh<_i652.DeleteFavoritePokemonUseCase>(),
      ),
    );
    gh.factory<_i702.GetPokemonDetailByIdBloc>(
      () => _i702.GetPokemonDetailByIdBloc(gh<_i652.GetPokemonDetailUseCase>()),
    );
    gh.factory<_i225.GetFavoritePokemonListBloc>(
      () => _i225.GetFavoritePokemonListBloc(
        gh<_i652.GetFavoritePokemonListUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i526.RegisterModule {}
