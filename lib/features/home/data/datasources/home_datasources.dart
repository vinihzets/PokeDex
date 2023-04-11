import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';

abstract class HomeDataSources {
  Future<Either<Failure, dynamic>> fetchAllPokemons();
}
