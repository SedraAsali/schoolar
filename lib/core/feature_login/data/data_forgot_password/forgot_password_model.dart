// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';


ForgotPasswordModel forgotPasswordModelFromJson(String str) =>
    ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) =>
    json.encode(data.toJson());

class ForgotPasswordModel {
  String? status;
  String? message;
  int? statusCode;

  ForgotPasswordModel({
    this.status,
    this.message,
    this.statusCode,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      status: json["status"],
      message: json["message"],
      statusCode: json["statusCode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "statusCode": statusCode,
    };
  }

  @override
  String toString() {
    return 'ForgotPasswordModel{status: $status, message: $message, statusCode: $statusCode}';
  }

}
