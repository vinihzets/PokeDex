abstract class BlocState<T> {
  T? data;

  BlocState({required this.data});
}

class BlocStableState extends BlocState {
  BlocStableState({required super.data});
}

class BlocEmptyState extends BlocState {
  BlocEmptyState({super.data});
}

class BlocErrorState extends BlocState {
  final String messageError;

  BlocErrorState({super.data, required this.messageError});
}
