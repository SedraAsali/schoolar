part of 'teachers_bloc.dart';


abstract class TeachersViewState extends Equatable {
  const TeachersViewState();

  @override
  List<Object?> get props => [];
}

class TeachersInitial extends TeachersViewState {}

class TeachersLoadingState extends TeachersViewState {}

class TeachersSuccessState extends TeachersViewState {

  final TeachersModel teachersModel;

  const TeachersSuccessState({
    required this.teachersModel,
  });

  @override
  List<Object?> get props => [
    teachersModel,
  ];
}

class TeachersNoInternetState extends TeachersViewState {}

class TeachersUnauthorizedState extends TeachersViewState {

  final String? message;

  const TeachersUnauthorizedState({
    this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}

class TeachersForbiddenState extends TeachersViewState {

  final String? message;

  const TeachersForbiddenState({
    this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}

class TeachersServerErrorState extends TeachersViewState {

  final String? message;

  const TeachersServerErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}

class TeachersErrorState extends TeachersViewState {

  final String? message;

  const TeachersErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [
  message
  ];
}

