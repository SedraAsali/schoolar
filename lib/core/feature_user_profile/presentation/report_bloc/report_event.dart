part of 'report_bloc.dart';

abstract class ReportViewEvent extends Equatable {
  const ReportViewEvent();
}

class AddReportEvent extends ReportViewEvent {
  final BuildContext context;
  final String title;
  final String description;
  final String type;
  final String academyId;

  const AddReportEvent({
    required this.context,
    required this.title,
    required this.description,
    required this.type,
    required this.academyId,
  });

  @override
  List<Object> get props => [
    context,
    title,
    description,
    type,
    academyId,
  ];
}