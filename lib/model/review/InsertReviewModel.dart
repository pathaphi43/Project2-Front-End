// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

List<InsertReviewsModel> insertreviewModelFromJson(String str) => List<InsertReviewsModel>.from(json.decode(str).map((x) => InsertReviewsModel.fromJson(x)));

String insertreviewModelToJson(List<InsertReviewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String insertreviewToJson(InsertReviewsModel data) => json.encode(data.toJson());

class InsertReviewsModel {
  InsertReviewsModel({
    this.id,
    this.rid,
    this.tid,
    this.reviewsText,
    this.reviewsScore,
    this.reviewsDate,
    this.reviewsStatus,

  });

  int id;
  int rid;
  int tid;
  String reviewsText;
  int reviewsScore;
  DateTime reviewsDate;
  int reviewsStatus;


  factory InsertReviewsModel.fromJson(Map<String, dynamic> json) => InsertReviewsModel(
    id: json["id"],
    rid: json["rid"],
    tid: json["tid"],
    reviewsText: json["reviewsText"] == null ? null :json["reviewsText"],
    reviewsScore: json["reviewsScore"],
    reviewsDate: DateTime.parse(json["reviewsDate"]),
    reviewsStatus: json["reviewsStatus"] == null ? null :json["reviewsStatus"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rid": rid,
    "tid": tid,
    "reviewsText": reviewsText == null ? null :reviewsText,
    "reviewsScore": reviewsScore,
    "reviewsDate": reviewsDate.toIso8601String(),
    "reviewsStatus": reviewsStatus == null ? null :reviewsStatus

  };
}


