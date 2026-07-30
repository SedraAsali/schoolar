part of 'favorites_view_bloc.dart';

abstract class FavoritesViewEvent extends Equatable {
  const FavoritesViewEvent();
}

class LoadingFavoritesViewEvent extends FavoritesViewEvent {
  final BuildContext? context;
  final String? userID;

  const LoadingFavoritesViewEvent({
    required this.context,
    required this.userID,
  });

  @override
  List<Object?> get props => [context,userID];
}


