part of 'delete_favorite_bloc.dart';

sealed class DeleteFavoriteEvent extends Equatable {
  const DeleteFavoriteEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoriteViewEvent extends DeleteFavoriteEvent {
  final BuildContext context;
  final String favoriteId;

  const DeleteFavoriteViewEvent({
    required this.context,
    required this.favoriteId,
  });

  @override
  List<Object> get props => [favoriteId];
}