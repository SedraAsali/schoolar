// To parse this JSON data, do
//
//     final addFavoriteModel = addFavoriteModelFromJson(jsonString);

import 'dart:convert';

AddFavoriteModel addFavoriteModelFromJson(String str) => AddFavoriteModel.fromJson(json.decode(str));

String addFavoriteModelToJson(AddFavoriteModel data) => json.encode(data.toJson());

class AddFavoriteModel {
  String? message;
  Favorite? favorite;

  AddFavoriteModel({
    this.message,
    this.favorite,
  });

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) => AddFavoriteModel(
    message: json["message"],
    favorite: json["favorite"] == null ? null : Favorite.fromJson(json["favorite"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "favorite": favorite?.toJson(),
  };

  @override
  String toString() {
    return 'AddFavoriteModel{message: $message, favorite: $favorite}';
  }

}

class Favorite {
  String? academyId;
  String? userId;
  String? id;
  int? v;

  Favorite({
    this.academyId,
    this.userId,
    this.id,
    this.v,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    academyId: json["academyId"],
    userId: json["userId"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "academyId": academyId,
    "userId": userId,
    "_id": id,
    "__v": v,
  };

  @override
  String toString() {
    return 'Favorite{academyId: $academyId, userId: $userId, id: $id, v: $v}';
  }

}
