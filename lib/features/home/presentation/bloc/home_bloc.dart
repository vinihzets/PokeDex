import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokedex/architeture/bloc_state.dart';
import 'package:pokedex/core/utils/hud_mixins.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_info_usecase.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_usecase.dart';
import 'package:pokedex/features/home/presentation/bloc/home_event.dart';

class HomeBloc with HudMixins {
  FetchAllPokemonsUseCase fetchAllPokemonsUseCase;
  FetchAllPokemonsInfoUseCase fetchAllPokemonsInfoUseCase;

  late StreamController<BlocState> _statePokemons;
  Stream<BlocState> get statePokemons => _statePokemons.stream;

  late StreamController<BlocState> _statePokemonsInfo;
  Stream<BlocState> get statePokemonsInfo => _statePokemonsInfo.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc(this.fetchAllPokemonsUseCase, this.fetchAllPokemonsInfoUseCase) {
    _event = StreamController.broadcast();
    _statePokemons = StreamController.broadcast();

    _statePokemonsInfo = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  dispatchState(BlocState state) {
    _statePokemons.add(state);
  }

  dispatchStatePokemonsInfo(BlocState state) {
    _statePokemonsInfo.add(state);
  }

  dispatchEvent(HomeEvent event) {
    _event.add(event);
  }

  _mapListenEvent(HomeEvent event) {
    if (event is HomeEventFetchAllPokemons) {
      fetchAllPokemons(event.context);
    } else if (event is HomeEventFetchAllPokemonsInfo) {
      fetchAllPokemonsInfo(event.context, event.url);
    }
  }

  fetchAllPokemons(BuildContext context) async {
    final fetchRequest = await fetchAllPokemonsUseCase.fetchAllPokemons();
    fetchRequest.fold((left) {
      showSnack(context, left.message);
    }, (right) {
      dispatchState(BlocStableState(data: right));
    });
  }

  fetchAllPokemonsInfo(BuildContext context, String url) async {
    final request = await fetchAllPokemonsInfoUseCase.fetchAllPokemonsInfo(url);
    request.fold((left) {
      showSnack(context, left.message);
    }, (right) {
      dispatchStatePokemonsInfo(BlocStableState(data: right));
    });
  }
}
