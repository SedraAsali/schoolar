part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileErrorState extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileImageUploadFailedState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessEditState extends ProfileState {
  final LogInModel userObject;

  const ProfileSuccessEditState(this.userObject);

  @override
  List<Object> get props => [];
}

class ProfileImageSuccessEditState extends ProfileState {
  final LogInModel userObject;

  const ProfileImageSuccessEditState(this.userObject);

  @override
  List<Object> get props => [];
}

class ProfileSuccessChangePasswordState extends ProfileState {

  @override
  List<Object> get props => [];
}

class ProfileFailedChangePasswordState extends ProfileState {

  @override
  List<Object> get props => [];
}

class ProfileSuccessLogOutState extends ProfileState {

  @override
  List<Object> get props => [];
}

class ProfileErrorLogOutState extends ProfileState {

  @override
  List<Object> get props => [];
}






