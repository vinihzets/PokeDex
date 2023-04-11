import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:http/http.dart' as http;

class HomeDataSourcesRemoteImp implements HomeDataSources {
  @override
  Future<Either<Failure, dynamic>> fetchAllPokemons() async {
    String api = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=700';

    try {
      final response = await http.get(Uri.parse(api));

      final decode = jsonDecode(response.body);

      inspect(decode);

      return Right(decode);
    } on HttpException catch (e) {
      return Left(RemoteFailure(message: e.message));
    }
  }
}
