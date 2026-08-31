// To parse this JSON data, do
//
//     final homeViewModel = homeViewModelFromJson(jsonString);

import 'dart:convert';

HomeViewModel homeViewModelFromJson(String str) => HomeViewModel.fromJson(json.decode(str));

String homeViewModelToJson(HomeViewModel data) => json.encode(data.toJson());

class HomeViewModel {
  String? status;
  int? results;
  List<Doc>? doc;

  HomeViewModel({
    this.status,
    this.results,
    this.doc,
  });

  factory HomeViewModel.fromJson(Map<String, dynamic> json) => HomeViewModel(
    status: json["status"],
    results: json["results"],
    doc: json["doc"] == null ? [] : List<Doc>.from(json["doc"]!.map((x) => Doc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results,
    "doc": doc == null ? [] : List<dynamic>.from(doc!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'HomeViewModel{status: $status, results: $results, doc: $doc}';
  }

}

class Doc {
  int? ratingsAverage;
  int? ratingsQuantity;
  String? id;
  ManagerId? managerId;
  String? photo;
  String? name;
  String? region;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;

  Doc({
    this.ratingsAverage,
    this.ratingsQuantity,
    this.id,
    this.managerId,
    this.photo,
    this.name,
    this.region,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    ratingsAverage: (json["ratingsAverage"] as num?)?.toInt(),
    ratingsQuantity: json["ratingsQuantity"],
    id: json["_id"],
    managerId: json["managerId"] == null ? null : ManagerId.fromJson(json["managerId"]),
    photo: json["photo"],
    name: json["name"],
    region: json["region"],
    location: json["location"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "ratingsAverage": ratingsAverage,
    "ratingsQuantity": ratingsQuantity,
    "_id": id,
    "managerId": managerId?.toJson(),
    "photo": photo,
    "name": name,
    "region": region,
    "location": location,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'Doc{ratingsAverage: $ratingsAverage, ratingsQuantity: $ratingsQuantity, id: $id, managerId: $managerId, photo: $photo, name: $name, region: $region, location: $location, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

}

class ManagerId {
  String? id;
  String? phone;

  ManagerId({
    this.id,
    this.phone,
  });

  factory ManagerId.fromJson(Map<String, dynamic> json) => ManagerId(
    id: json["_id"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
  };

  @override
  String toString() {
    return 'ManagerId{id: $id, phone: $phone}';
  }

}
