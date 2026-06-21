// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  String? status;
  int? statusCode;
  String? token;
  String? message;
  User? user;

  LogInModel({
    this.status,
    this.statusCode,
    this.token,
    this.message,
    this.user,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
    status: json["status"],
    statusCode: json["statusCode"],
    token: json["token"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "token": token,
    "message": message,
    "user": user?.toJson(),
  };

  @override
  String toString() {
    return 'LogInModel{status: $status, statusCode: $statusCode, token: $token, message: $message, user: $user}';
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? photo;
  String? role;
  bool? active;
  DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.photo,
    this.role,
    this.active,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    photo: json["photo"],
    role: json["role"],
    active: json["active"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "photo": photo,
    "role": role,
    "active": active,
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, photo: $photo, role: $role, active: $active, createdAt: $createdAt}';
  }
}
