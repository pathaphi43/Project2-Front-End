// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

List<TransactionModel> transactionModelFromJson(String str) => List<TransactionModel>.from(json.decode(str).map((x) => TransactionModel.fromJson(x)));

String transactionModelToJson(List<TransactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

TransactionModel transactionFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionImageToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.id,
    this.rid,
    this.installment,
    this.payHouseAmount,
    this.payHouseDate,
    this.payHouseEnd,
    this.payHouseImg,
    this.payHouseStatus,
    this.payElecInmonth,
    this.payElecAmount,
    this.payElecDate,
    this.payElecEnd,
    this.payElecImg,
    this.payElecStatus,
    this.payWaterInmonth,
    this.payWaterAmount,
    this.payWaterDate,
    this.payWaterEnd,
    this.payWaterImg,
    this.payWaterStatus,
  });

  int id;
  int rid;
  DateTime installment;
  int payHouseAmount;
  dynamic payHouseDate;
  DateTime payHouseEnd;
  dynamic payHouseImg;
  int payHouseStatus;
  DateTime payElecInmonth;
  String payElecAmount;
  dynamic payElecDate;
  DateTime payElecEnd;
  dynamic payElecImg;
  int payElecStatus;
  DateTime payWaterInmonth;
  String payWaterAmount;
  dynamic payWaterDate;
  DateTime payWaterEnd;
  dynamic payWaterImg;
  int payWaterStatus;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    id: json["id"],
    rid: json["rid"],
    installment: DateTime.parse(json["installment"]),
    payHouseAmount: json["payHouseAmount"],
    payHouseDate: json["payHouseDate"],
    payHouseEnd: DateTime.parse(json["payHouseEnd"]),
    payHouseImg: json["payHouseImg"],
    payHouseStatus: json["payHouseStatus"],
    payElecInmonth: DateTime.parse(json["payElecInmonth"]),
    payElecAmount: json["payElecAmount"],
    payElecDate: json["payElecDate"],
    payElecEnd: DateTime.parse(json["payElecEnd"]),
    payElecImg: json["payElecImg"],
    payElecStatus: json["payElecStatus"],
    payWaterInmonth: DateTime.parse(json["payWaterInmonth"]),
    payWaterAmount: json["payWaterAmount"],
    payWaterDate: json["payWaterDate"],
    payWaterEnd: DateTime.parse(json["payWaterEnd"]),
    payWaterImg: json["payWaterImg"],
    payWaterStatus: json["payWaterStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rid": rid,
    "installment": installment.toIso8601String(),
    "payHouseAmount": payHouseAmount,
    "payHouseDate": payHouseDate,
    "payHouseEnd": payHouseEnd.toIso8601String(),
    "payHouseImg": payHouseImg,
    "payHouseStatus": payHouseStatus,
    "payElecInmonth": payElecInmonth.toIso8601String(),
    "payElecAmount": payElecAmount,
    "payElecDate": payElecDate,
    "payElecEnd": payElecEnd.toIso8601String(),
    "payElecImg": payElecImg,
    "payElecStatus": payElecStatus,
    "payWaterInmonth": payWaterInmonth.toIso8601String(),
    "payWaterAmount": payWaterAmount,
    "payWaterDate": payWaterDate,
    "payWaterEnd": payWaterEnd.toIso8601String(),
    "payWaterImg": payWaterImg,
    "payWaterStatus": payWaterStatus,
  };
}
