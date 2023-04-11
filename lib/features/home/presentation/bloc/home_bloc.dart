import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex/architeture/bloc_state.dart';
import 'package:pokedex/core/utils/hud_mixins.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_usecase.dart';
import 'package:pokedex/features/home/presentation/bloc/home_event.dart';

class HomeBloc with HudMixins {
  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  FetchAllPokemonsUseCase fetchAllPokemonsUseCase;

  HomeBloc(this.fetchAllPokemonsUseCase) {
    _state = StreamController.broadcast();

    _event = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  dispatchEvent(HomeEvent event) {
    _event.add(event);
  }

  _mapListenEvent(HomeEvent event) {
    if (event is HomeEvent) {}
  }

  fetchAllPokemons(BuildContext context) async {
    final fetchRequest = await fetchAllPokemonsUseCase.fetchAllPokemons();
    fetchRequest.fold((left) {
      showSnack(context, left.message);
    }, (right) {
      inspect(right);
    });
  }
}
