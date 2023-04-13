import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/features/home/data/dtos/fetch_pokes_dto.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';

class HomeDataSourcesRemoteImp implements HomeDataSources {
  @override
  Future<Either<Failure, List<FetchPokesDto>>> fetchAllPokemons() async {
    String api = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=50';

    try {
      final response = await http.get(Uri.parse(api));

      final decode = jsonDecode(response.body);

      final objectDecode = decode['results'] as List;
      final result =
          objectDecode.map((e) => FetchPokesDto.fromJson(e)).toList();

      return Right(result);
    } on HttpException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> fetchPokemonInfo(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      final decode = jsonDecode(response.body);

      final parser = PokemonEntity.fromJson(decode);

      return Right(parser);
    } on HttpException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }

  @override
  Future<PokemonEntity> getPokemonByName(String name) async {
    final api = 'https://pokeapi.co/api/v2/pokemon/$name';

    final response = await http.get(Uri.parse(api));

    final decode = jsonDecode(response.body);
    final parser = PokemonEntity.fromJson(decode);

    return parser;
  }
}
