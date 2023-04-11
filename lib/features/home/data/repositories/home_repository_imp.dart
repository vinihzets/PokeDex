import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:pokedex/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSources homeDataSources;

  HomeRepositoryImp(this.homeDataSources);

  @override
  Future<Either<Failure, dynamic>> fetchAllPokemons() {
    return homeDataSources.fetchAllPokemons();
  }
}
