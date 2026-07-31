// To parse this JSON data, do
//
//     final addFavoriteModel = addFavoriteModelFromJson(jsonString);

import 'dart:convert';

AddFavoriteModel addFavoriteModelFromJson(String str) => AddFavoriteModel.fromJson(json.decode(str));

String addFavoriteModelToJson(AddFavoriteModel data) => json.encode(data.toJson());

class AddFavoriteModel {
  String? message;
  Favorite? favorite;
  AddFavoriteError? error;

  AddFavoriteModel({
    this.message,
    this.favorite,
    this.error,
  });

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) {
    return AddFavoriteModel(
      message: json["message"],
      favorite: json["favorite"] != null
          ? Favorite.fromJson(json["favorite"])
          : null,
      error: json["error"] != null
          ? AddFavoriteError.fromJson(json["error"])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "favorite": favorite?.toJson(),
      "error": error?.toJson(),
    };
  }

  @override
  String toString() {
    return 'AddFavoriteModel{message: $message, favorite: $favorite, error: $error}';
  }

}


class AddFavoriteError {
  String? stringValue;
  String? valueType;
  String? kind;
  String? value;
  String? path;
  String? name;
  String? message;

  AddFavoriteError({
    this.stringValue,
    this.valueType,
    this.kind,
    this.value,
    this.path,
    this.name,
    this.message,
  });

  factory AddFavoriteError.fromJson(Map<String, dynamic> json) {
    return AddFavoriteError(
      stringValue: json["stringValue"],
      valueType: json["valueType"],
      kind: json["kind"],
      value: json["value"],
      path: json["path"],
      name: json["name"],
      message: json["message"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "stringValue": stringValue,
      "valueType": valueType,
      "kind": kind,
      "value": value,
      "path": path,
      "name": name,
      "message": message,
    };
  }

  @override
  String toString() {
    return 'AddFavoriteError{stringValue: $stringValue, valueType: $valueType, kind: $kind, value: $value, path: $path, name: $name, message: $message}';
  }

}


class Favorite {
  String? id;
  String? academyId;
  String? userId;
  int? v;

  Favorite({
    this.id,
    this.academyId,
    this.userId,
    this.v,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json["_id"],
      academyId: json["academyId"],
      userId: json["userId"],
      v: json["__v"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "academyId": academyId,
      "userId": userId,
      "__v": v,
    };
  }

  @override
  String toString() {
    return 'Favorite{id: $id, academyId: $academyId, userId: $userId, v: $v}';
  }

}