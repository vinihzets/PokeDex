import 'package:flutter/material.dart';
import 'package:pokedex/core/utils/consts.dart';
import 'package:pokedex/features/splash/presentation/ui/splash_screen.dart';
import 'package:pokedex/repository/pokemon_repository.dart';
import 'package:pokedex/features/home/presentation/ui/home_screen.dart';

final gPokemonRepository = PokemonRepository();
final gConstsRoutes = ConstsRoutes();
final gConstsImages = ConstsImages();
Future<void> main() async {
  runApp(MaterialApp(
    routes: {
      gConstsRoutes.splashScreen: (_) => const SplashScreen(),
      gConstsRoutes.homeScreen: (_) => const HomeScreen()
    },
    initialRoute: gConstsRoutes.splashScreen,
  ));
}
