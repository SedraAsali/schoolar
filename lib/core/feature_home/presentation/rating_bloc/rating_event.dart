part of 'rating_bloc.dart';

abstract class RatingViewEvent extends Equatable {
  const RatingViewEvent();
}

class AddRatingEvent extends RatingViewEvent {
  final BuildContext context;
  final String academyId;
  final double rating;

  const AddRatingEvent({
    required this.context,
    required this.academyId,
    required this.rating,
  });

  @override
  List<Object?> get props => [
    academyId,
    rating,
  ];
}
