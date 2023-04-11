import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/core/utils/consts.dart';
import 'package:pokedex/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:pokedex/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc bloc;
  late ConstsRoutes constsRoutes;

  @override
  void initState() {
    bloc = GetIt.I.get();
    constsRoutes = GetIt.I.get();

    Future.delayed(const Duration(seconds: 3)).then(
        (_) => bloc.navigateRemoveUntil(context, constsRoutes.homeScreen));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
