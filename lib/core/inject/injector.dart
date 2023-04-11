import 'package:get_it/get_it.dart';
import 'package:pokedex/core/utils/consts.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:pokedex/features/home/data/datasources/remote/home_datasources_remote_imp.dart';
import 'package:pokedex/features/home/data/repositories/home_repository_imp.dart';
import 'package:pokedex/features/home/domain/repositories/home_repository.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_info_usecase.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_info_usecase_imp.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_usecase.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_usecase_imp.dart';
import 'package:pokedex/features/home/presentation/bloc/home_bloc.dart';
import 'package:pokedex/features/splash/presentation/bloc/splash_bloc.dart';

class Injector {
  static inject() {
    GetIt getIt = GetIt.instance;

    //core

    getIt.registerLazySingleton(() => ConstsImages());
    getIt.registerLazySingleton(() => ConstsRoutes());

    //datasources

    getIt.registerLazySingleton<HomeDataSources>(
        () => HomeDataSourcesRemoteImp());

    //repositories

    getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImp(getIt()));
    //usecases

    getIt.registerLazySingleton<FetchAllPokemonsInfoUseCase>(
        () => FetchAllPokemonsInfoUseCaseImp(getIt()));

    getIt.registerLazySingleton<FetchAllPokemonsUseCase>(
        () => FetchAllPokemonsUseCaseImp(getIt()));

    //bloc

    getIt.registerFactory(() => SplashBloc());

    getIt.registerFactory(() => HomeBloc(getIt(), getIt()));
  }
}
