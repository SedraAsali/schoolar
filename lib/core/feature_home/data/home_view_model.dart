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
  String? id;
  String? managerId;
  String? photo;
  String? name;
  String? region;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;

  Doc({
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
    id: json["_id"],
    managerId: json["managerId"],
    photo: json["photo"],
    name: json["name"],
    region: json["region"],
    location: json["location"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "managerId": managerId,
    "photo": photo,
    "name": name,
    "region": region,
    "location": location,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'Doc{id: $id, managerId: $managerId, photo: $photo, name: $name, region: $region, location: $location, createdAt: $createdAt, updatedAt: $updatedAt}';
  }


}
