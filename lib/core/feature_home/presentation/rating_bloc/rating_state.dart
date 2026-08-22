part of 'rating_bloc.dart';

abstract class RatingViewState extends Equatable {
  const RatingViewState();

  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingViewState {}

class RatingLoadingState extends RatingViewState {}

class RatingSuccessState extends RatingViewState {
  final RatingModel ratingModel;

  const RatingSuccessState({
    required this.ratingModel,
  });

  @override
  List<Object?> get props => [
    ratingModel,
  ];
}

class RatingNoInternetState extends RatingViewState {}

class RatingUnauthorizedState extends RatingViewState {
  final String? message;

  const RatingUnauthorizedState({
    this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}

class RatingErrorState extends RatingViewState {
  final String? message;

  const RatingErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}
