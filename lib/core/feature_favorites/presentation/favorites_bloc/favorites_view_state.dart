part of 'favorites_view_bloc.dart';

abstract class FavoritesViewState extends Equatable {
  const FavoritesViewState();
}

class FavoritesViewInitial extends FavoritesViewState {
  @override
  List<Object> get props => [];
}

class ErrorFavoritesViewState extends FavoritesViewState{
  final String message;
  const ErrorFavoritesViewState({required this.message});
  @override
  List<Object> get props => [message];

}
class NoInternetFavoritesViewState extends FavoritesViewState{
  @override
  List<Object> get props => [];

}
class LoadingFavoritesViewState extends FavoritesViewState{
  @override
  List<Object> get props => [];
}

class GetAllFavoritesViewState extends FavoritesViewState{
  GetFavoriteModel getFavoriteModel;
  GetAllFavoritesViewState({required this.getFavoriteModel});
  @override
  List<Object> get props => [getFavoriteModel];
}



