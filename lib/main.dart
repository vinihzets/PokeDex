import 'package:flutter/material.dart';
import 'package:pokedex/repository/constsapp.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/container/home_screen.dart';

final gPokemonRepository = PokemonRepository();
final gConsts = Consts();

Future<void> main() async {
  runApp(MaterialApp(
    routes: {'/': (_) => const HomeScreen()},
    initialRoute: '/',
  ));
}
