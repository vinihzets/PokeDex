import 'dart:async';

import 'package:pokedex/architeture/bloc_state.dart';
import 'package:pokedex/features/home/presentation/bloc/home_event.dart';

class HomeBloc {
  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc() {
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
}
