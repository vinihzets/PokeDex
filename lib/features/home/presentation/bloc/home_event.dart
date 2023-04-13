import 'package:flutter/material.dart';

abstract class HomeEvent {}

class HomeEventFetchAllPokemons implements HomeEvent {
  BuildContext context;

  HomeEventFetchAllPokemons(this.context);
}

class HomeEventFetchAllPokemonsInfo implements HomeEvent {
  BuildContext context;
  String url;

  HomeEventFetchAllPokemonsInfo(this.context, this.url);
}
