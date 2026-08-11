part of 'teachers_bloc.dart';


abstract class TeachersViewEvent extends Equatable {
  const TeachersViewEvent();
}


// جلب الأساتذة
class LoadingTeachersViewEvent extends TeachersViewEvent {

  final BuildContext context;
  final String academyId;

  const LoadingTeachersViewEvent({
    required this.context,
    required this.academyId,
  });

  @override
  List<Object> get props => [
    academyId,
  ];
}
