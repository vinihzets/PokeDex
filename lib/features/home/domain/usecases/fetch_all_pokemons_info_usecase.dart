import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';

abstract class FetchAllPokemonsInfoUseCase {
  Future<Either<Failure, dynamic>> fetchAllPokemonsInfo(String url);
}
