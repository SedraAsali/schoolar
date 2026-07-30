class GetFavoriteModel {
  String? status;
  String? message;
  List<Favorite>? data;

  GetFavoriteModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetFavoriteModel.fromJson(dynamic json) {

    // حالة النجاح: API يرجع List
    if (json is List) {
      return GetFavoriteModel(
        status: "success",
        data: json
            .map((e) => Favorite.fromJson(e))
            .toList(),
      );
    }

    // حالة الفشل: API يرجع Object
    return GetFavoriteModel(
      status: json["status"],
      message: json["message"],
    );
  }

}


class Favorite {
  String? id;
  Academy? academyId;
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
      academyId: json["academyId"] != null
          ? Academy.fromJson(json["academyId"])
          : null,
      userId: json["userId"],
      v: json["__v"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "academyId": academyId?.toJson(),
      "userId": userId,
      "__v": v,
    };
  }
}


class Academy {
  String? id;
  String? managerId;
  String? photo;
  String? name;
  String? region;
  String? location;
  String? createdAt;
  String? updatedAt;

  Academy({
    this.id,
    this.managerId,
    this.photo,
    this.name,
    this.region,
    this.location,
    this.createdAt,
    this.updatedAt,
  });


  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      id: json["_id"],
      managerId: json["managerId"],
      photo: json["photo"],
      name: json["name"],
      region: json["region"],
      location: json["location"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "managerId": managerId,
      "photo": photo,
      "name": name,
      "region": region,
      "location": location,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}