part of 'pagoda_bloc.dart';

@immutable
abstract class PagodaState {}

class StartState extends PagodaState {}

class LoadingState extends PagodaState {}

class SuccessState extends PagodaState {
  final List<PagodaOb> pagodaOb;
  SuccessState(this.pagodaOb);
}

class FailState extends PagodaState {
  final String error;
  FailState(this.error);
}
