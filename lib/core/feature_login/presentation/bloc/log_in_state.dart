part of 'log_in_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();
}

class LogInInitial extends LogInState {
  @override
  List<Object> get props => [];
}

class Loading extends LogInState {
  @override
  List<Object> get props => [];
}

class LogInDone extends LogInState {
  final LogInModel res;

  LogInDone(this.res);

  @override
  List<Object> get props => [res];
}

class LogInNoAuth extends  LogInState{
  @override
  List<Object> get props => [];
}

class LogInFailed extends LogInState {
  @override
  List<Object> get props => [];
}

class LogInNoInternet extends LogInState {
  @override
  List<Object> get props => [];
}

class LogInError extends LogInState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
