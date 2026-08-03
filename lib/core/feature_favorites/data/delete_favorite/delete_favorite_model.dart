// To parse this JSON data, do
//
// final deleteFavoriteModel = deleteFavoriteModelFromJson(response.body);

import 'dart:convert';

DeleteFavoriteModel deleteFavoriteModelFromJson(String str) =>
    DeleteFavoriteModel.fromJson(json.decode(str));

String deleteFavoriteModelToJson(DeleteFavoriteModel data) =>
    json.encode(data.toJson());

class DeleteFavoriteModel {
  String? status;
  String? message;

  DeleteFavoriteModel({
    this.status,
    this.message,
  });

  factory DeleteFavoriteModel.fromJson(Map<String, dynamic> json) {
    return DeleteFavoriteModel(
      status: json["status"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
    };
  }

  @override
  String toString() {
    return 'DeleteFavoriteModel{message: $message,status: $status}';
  }
}