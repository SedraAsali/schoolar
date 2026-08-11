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


