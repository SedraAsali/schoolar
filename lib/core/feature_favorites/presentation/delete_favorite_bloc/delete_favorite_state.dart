part of 'delete_favorite_bloc.dart';

sealed class DeleteFavoriteState extends Equatable {
  const DeleteFavoriteState();

  @override
  List<Object?> get props => [];
}

final class DeleteFavoriteInitial extends DeleteFavoriteState {}

final class LoadingDeleteFavoriteState extends DeleteFavoriteState {}

final class SuccessDeleteFavoriteState extends DeleteFavoriteState {
  final DeleteFavoriteModel deleteFavoriteModel;

  const SuccessDeleteFavoriteState({
    required this.deleteFavoriteModel,
  });

  @override
  List<Object?> get props => [deleteFavoriteModel];
}

final class ErrorDeleteFavoriteState extends DeleteFavoriteState {
  final String message;

  const ErrorDeleteFavoriteState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

final class NoInternetDeleteFavoriteState extends DeleteFavoriteState {}