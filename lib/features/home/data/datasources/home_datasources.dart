import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/domain/entities/fetch_pokes_entity.dart';

abstract class HomeDataSources {
  Future<Either<Failure, List<FetchPokesEntity>>> fetchAllPokemons();
  Future<Either<Failure, dynamic>> fetchAllPokemonsInfo(String url);
}
