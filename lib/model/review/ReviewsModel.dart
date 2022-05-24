// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

List<ReviewsModel> reviewsModelFromJson(String str) => List<ReviewsModel>.from(json.decode(str).map((x) => ReviewsModel.fromJson(x)));

String reviewsModelToJson(List<ReviewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String reviewsToJson(ReviewsModel data) => json.encode(data.toJson());

class ReviewsModel {
  ReviewsModel({
    this.id,
    this.rid,
    this.tid,
    this.reviewsText,
    this.reviewsScore,
    this.reviewsDate,
    this.reviewsStatus,
    this.reviewsImage,
  });

  int id;
  int rid;
  int tid;
  String reviewsText;
  int reviewsScore;
  DateTime reviewsDate;
  int reviewsStatus;
  List<ReviewsImage> reviewsImage;

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
    id: json["id"],
    rid: json["rid"],
    tid: json["tid"],
    reviewsText: json["reviewsText"] == null ? null :json["reviewsText"],
    reviewsScore: json["reviewsScore"],
    reviewsDate: DateTime.parse(json["reviewsDate"]),
    reviewsStatus: json["reviewsStatus"] == null ? null :json["reviewsStatus"],
    reviewsImage:json["reviewsImage"] == null ? null :  List<ReviewsImage>.from(json["reviewsImage"].map((x) => ReviewsImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rid": rid,
    "tid": tid,
    "reviewsText": reviewsText == null ? null :reviewsText,
    "reviewsScore": reviewsScore,
    "reviewsDate": reviewsDate.toIso8601String(),
    "reviewsStatus": reviewsStatus == null ? null :reviewsStatus,
    "reviewsImage":reviewsImage == null? null : List<dynamic>.from(reviewsImage.map((x) => x.toJson())),
  };
}

class ReviewsImage {
  ReviewsImage({
    this.pid,
    this.rid,
    this.reviewsImage,
  });

  int pid;
  int rid;
  String reviewsImage;

  factory ReviewsImage.fromJson(Map<String, dynamic> json) => ReviewsImage(
    pid: json["pid"],
    rid: json["rid"],
    reviewsImage: json["reviewsImage"],
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "rid": rid,
    "reviewsImage": reviewsImage,
  };
}
