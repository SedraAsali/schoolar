import 'dart:convert';

RatingModel ratingModelFromJson(String str) =>
    RatingModel.fromJson(json.decode(str));

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel {
  String? status;
  int? statusCode;
  String? message;

  RatingModel({this.status, this.statusCode, this.message});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      status: json["status"],
      statusCode: json["statusCode"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "statusCode": statusCode, "message": message};
  }

  @override
  String toString() {
    return 'RatingModel{'
        'status: $status, '
        'statusCode: $statusCode, '
        'message: $message'
        '}';
  }
}
