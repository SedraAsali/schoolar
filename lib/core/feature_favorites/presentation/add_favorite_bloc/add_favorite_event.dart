part of 'add_favorite_bloc.dart';

abstract class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();
}


class AddFavoriteViewEvent extends AddFavoriteEvent {

  final BuildContext context;
  final String academyId;
  final String userId;

  const AddFavoriteViewEvent({
    required this.context,
    required this.academyId,
    required this.userId,
  });


  @override
  List<Object> get props => [
    context,
    academyId,
    userId,
  ];

}