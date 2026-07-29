part of 'home_view_bloc.dart';

abstract class HomeViewState extends Equatable {
  const HomeViewState();
}

class HomeViewInitial extends HomeViewState {
  @override
  List<Object> get props => [];
}

class ErrorHomeViewState extends HomeViewState{
  @override
  List<Object> get props => [];

}
class NoInternetHomeViewState extends HomeViewState{
  @override
  List<Object> get props => [];

}
class LoadingHomeViewState extends HomeViewState{
  @override
  List<Object> get props => [];
}

class GetAllDataHomeViewState extends HomeViewState{
  HomeViewModel homeViewModel;
  GetAllDataHomeViewState({required this.homeViewModel});
  @override
  List<Object> get props => [homeViewModel];
}

// class SuccessFilterState extends HomeViewState{
//   final FilterModel filterModel;
//
//   SuccessFilterState(this.filterModel);
//
//   @override
//   List<Object> get props => [];
//
// }

