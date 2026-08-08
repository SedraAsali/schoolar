part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordDone extends ForgotPasswordState {
  final ForgotPasswordModel res;

  const ForgotPasswordDone(this.res);

  @override
  List<Object> get props => [res];
}

class ForgotPasswordNotFound extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
class ForgotPasswordBadRequest extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
class ForgotPasswordFailed extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordNoInternet extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

// class ForgotPasswordError extends ForgotPasswordState {
//   @override
//   // TODO: implement props
//   List<Object> get props => [];
// }
