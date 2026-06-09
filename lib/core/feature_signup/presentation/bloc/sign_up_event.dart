part of 'sign_up_bloc.dart';



abstract class SignUpEvent extends Equatable {
  const SignUpEvent();


}

class SignUpInit extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class SignUpCall extends SignUpEvent {
  String name;
  String email;
  String password;
  String role;
  BuildContext context;
  SignUpCall(this.context, this.name,this.email, this.password,this.role);
  @override
  List<Object> get props => [name,email, password,role];
}
