import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) =>
    json.encode(data.toJson());

class ReportModel {
  int? statusCode;
  int? status;
  String? message;
  Report? report;

  ReportModel({
    this.statusCode,
    this.status,
    this.message,
    this.report,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      statusCode: json["statusCode"],
      status: json["status"],
      message: json["message"],
      report: json["report"] == null
          ? null
          : Report.fromJson(json["report"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "status": status,
      "message": message,
      "report": report?.toJson(),
    };
  }

  @override
  String toString() {
    return 'ReportModel{'
        'statusCode: $statusCode, '
        'status: $status, '
        'message: $message, '
        'report: $report'
        '}';
  }
}

class Report {
  String? title;
  String? description;
  String? type;
  String? userId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Report({
    this.title,
    this.description,
    this.type,
    this.userId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      title: json["title"],
      description: json["description"],
      type: json["type"],
      userId: json["userId"],
      id: json["_id"],
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "type": type,
      "userId": userId,
      "_id": id,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Report{'
        'title: $title, '
        'description: $description, '
        'type: $type, '
        'userId: $userId, '
        'id: $id, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt'
        '}';
  }
}
