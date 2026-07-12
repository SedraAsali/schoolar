part of 'get_profile_cubit.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();
}

class GetProfileInitial extends GetProfileState {
  @override
  List<Object> get props => [];
}
class ProfileFetchLoadingState extends GetProfileState {
  @override
  List<Object> get props => [];
}
class ProfileFetchFailedState extends GetProfileState {
  @override
  List<Object> get props => [];
}
class ProfileFetchNoInternetState extends GetProfileState {
  @override
  List<Object> get props => [];
}
class ProfileFetchSuccessState extends GetProfileState {
  final LogInModel userObject;

  const ProfileFetchSuccessState({required this.userObject});

  @override
  List<Object> get props => [];
}
