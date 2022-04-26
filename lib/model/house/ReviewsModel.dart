// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

List<ReviewsModel> reviewsModelFromJson(String str) => List<ReviewsModel>.from(json.decode(str).map((x) => ReviewsModel.fromJson(x)));

String reviewsModelToJson(List<ReviewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  double reviewsScore;
  DateTime reviewsDate;
  int reviewsStatus;
  List<ReviewsImage> reviewsImage;

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
    id: json["id"],
    rid: json["rid"],
    tid: json["tid"],
    reviewsText: json["reviewsText"],
    reviewsScore: json["reviewsScore"].toDouble(),
    reviewsDate: DateTime.parse(json["reviewsDate"]),
    reviewsStatus: json["reviewsStatus"],
    reviewsImage: List<ReviewsImage>.from(json["reviewsImage"].map((x) => ReviewsImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rid": rid,
    "tid": tid,
    "reviewsText": reviewsText,
    "reviewsScore": reviewsScore,
    "reviewsDate": reviewsDate.toIso8601String(),
    "reviewsStatus": reviewsStatus,
    "reviewsImage": List<dynamic>.from(reviewsImage.map((x) => x.toJson())),
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
