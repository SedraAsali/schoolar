part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class Loading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpDone extends SignUpState {
  final LogInModel res;

  SignUpDone(this.res);

  @override
  List<Object> get props => [res];
}

class SignUpNoAuth extends  SignUpState{
  @override
  List<Object> get props => [];
}

class SignUpFailed extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpNoInternet extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpError extends SignUpState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
