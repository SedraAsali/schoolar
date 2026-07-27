part of 'home_view_bloc.dart';

abstract class HomeViewEvent extends Equatable {
  const HomeViewEvent();
}

class LoadingHomeViewEvent extends HomeViewEvent {
  final BuildContext context;

  const LoadingHomeViewEvent({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}

// class InitialFilterFoodEvent extends HomeViewEvent{
//   @override
//   List<Object> get props => [];
//
// }

// class FetchFilterEvent extends HomeViewEvent{
//   final int minPrice;
//   final int maxPrice;
//   final List<int> idsCategory;
//   final BuildContext context;
//
//   FetchFilterEvent({this.context,this.minPrice, this.maxPrice, this.idsCategory});
//   @override
//   List<Object> get props => [];
//
// }
