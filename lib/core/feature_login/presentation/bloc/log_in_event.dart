part of 'log_in_bloc.dart';



abstract class LogInEvent extends Equatable {
  const LogInEvent();


}

class LogInInit extends LogInEvent {
  @override
  List<Object> get props => [];
}

class LogInCall extends LogInEvent {
  String email;
  String password;
  BuildContext context;
  LogInCall(this.context, this.password, this.email);
  @override
  List<Object> get props => [email, password];
}
