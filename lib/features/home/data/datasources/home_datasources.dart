import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/data/dtos/fetch_pokes_dto.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';

abstract class HomeDataSources {
  Future<Either<Failure, List<FetchPokesDto>>> fetchAllPokemons();
  Future<Either<Failure, dynamic>> fetchPokemonInfo(String url);
  Future<PokemonEntity> getPokemonByName(String name);
}
