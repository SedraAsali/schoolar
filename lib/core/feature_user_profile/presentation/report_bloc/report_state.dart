part of 'report_bloc.dart';

abstract class ReportViewState extends Equatable {
  const ReportViewState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportViewState {}

class ReportLoadingState extends ReportViewState {}

class ReportSuccessState extends ReportViewState {
  final ReportModel reportModel;

  const ReportSuccessState({
    required this.reportModel,
  });

  @override
  List<Object?> get props => [reportModel];
}

class ReportNoInternetState extends ReportViewState {}

class ReportUnauthorizedState extends ReportViewState {
  final String? message;

  const ReportUnauthorizedState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ReportErrorState extends ReportViewState {
  final String? message;

  const ReportErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
