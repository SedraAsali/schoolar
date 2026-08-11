import 'dart:convert';

TeachersModel teachersModelFromJson(String str) =>
    TeachersModel.fromJson(json.decode(str));

String teachersModelToJson(TeachersModel data) =>
    json.encode(data.toJson());

class TeachersModel {
  String? status;
  int? statusCode;
  int? results;
  String? message;
  List<Teacher>? doc;

  TeachersModel({
    this.status,
    this.statusCode,
    this.results,
    this.message,
    this.doc,
  });

  factory TeachersModel.fromJson(Map<String, dynamic> json) {
    return TeachersModel(
      status: json["status"],
      statusCode: json["statusCode"],
      results: json["results"],
      message: json["message"],
      doc: json["doc"] == null
          ? []
          : List<Teacher>.from(
        json["doc"].map(
              (x) => Teacher.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "statusCode": statusCode,
      "results": results,
      "message": message,
      "doc": doc == null
          ? []
          : List<dynamic>.from(
        doc!.map(
              (x) => x.toJson(),
        ),
      ),
    };
  }

  @override
  String toString() {
    return 'TeachersModel{'
        'status: $status, '
        'statusCode: $statusCode, '
        'results: $results, '
        'message: $message, '
        'doc: $doc'
        '}';
  }
}

class Teacher {
  String? id;
  String? academyTeachId;
  String? name;
  String? specialization;
  String? phone;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Teacher({
    this.id,
    this.academyTeachId,
    this.name,
    this.specialization,
    this.phone,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json["_id"],
      academyTeachId: json["academyTeachId"],
      name: json["name"],
      specialization: json["specialization"],
      phone: json["phone"],
      description: json["description"],
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
      "_id": id,
      "academyTeachId": academyTeachId,
      "name": name,
      "specialization": specialization,
      "phone": phone,
      "description": description,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Teacher{'
        'id: $id, '
        'academyTeachId: $academyTeachId, '
        'name: $name, '
        'specialization: $specialization, '
        'phone: $phone, '
        'description: $description'
        '}';
  }
}