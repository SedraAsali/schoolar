part of 'add_favorite_bloc.dart';

abstract class AddFavoriteState extends Equatable {
  const AddFavoriteState();
}


class AddFavoriteInitial extends AddFavoriteState {

  @override
  List<Object> get props => [];

}


class LoadingAddFavoriteState extends AddFavoriteState {

  @override
  List<Object> get props => [];

}


class SuccessAddFavoriteState extends AddFavoriteState {

  final AddFavoriteModel addFavoriteModel;

  const SuccessAddFavoriteState({
    required this.addFavoriteModel,
  });


  @override
  List<Object> get props => [
    addFavoriteModel,
  ];

}


class ErrorAddFavoriteState extends AddFavoriteState {

  final String message;

  const ErrorAddFavoriteState({
    required this.message,
  });


  @override
  List<Object> get props => [
    message,
  ];

}


class NoInternetAddFavoriteState extends AddFavoriteState {

  @override
  List<Object> get props => [];

}