import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:pokedex/features/home/domain/entities/fetch_pokes_entity.dart';
import 'package:pokedex/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSources homeDataSources;

  HomeRepositoryImp(this.homeDataSources);

  @override
  Future<Either<Failure, List<FetchPokesEntity>>> fetchAllPokemons() {
    return homeDataSources.fetchAllPokemons();
  }

  @override
  Future<Either<Failure, dynamic>> fetchAllPokemonsInfo(String url) {
    return homeDataSources.fetchPokemonInfo(url);
  }
}
