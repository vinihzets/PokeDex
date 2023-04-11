import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSources homeDataSources;

  HomeRepositoryImp(this.homeDataSources);

  Future<Either<Failure, dynamic>> fetchAllPokemons() {
    return homeDataSources.fetchAllPokemons();
  }
}
