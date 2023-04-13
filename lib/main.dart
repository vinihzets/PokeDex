import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/core/inject/injector.dart';
import 'package:pokedex/core/utils/consts.dart';
import 'package:pokedex/features/splash/presentation/ui/splash_screen.dart';
import 'package:pokedex/features/home/presentation/ui/home_screen.dart';

Future main() async {
  Injector.inject();
  late ConstsRoutes routesConsts;

  routesConsts = GetIt.I.get();

  runApp(MaterialApp(
    routes: {
      routesConsts.splashScreen: (_) => const SplashScreen(),
      routesConsts.homeScreen: (_) => const HomeScreen()
    },
    initialRoute: routesConsts.splashScreen,
  ));
}
