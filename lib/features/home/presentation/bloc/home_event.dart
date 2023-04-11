import 'package:flutter/material.dart';

abstract class HomeEvent {}

class HomeEventFetchAllPokemons implements HomeEvent {
  BuildContext context;

  HomeEventFetchAllPokemons(this.context);
}
