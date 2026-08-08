part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordEventRequest extends ForgotPasswordEvent {
  final String email;


  const ForgotPasswordEventRequest({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
