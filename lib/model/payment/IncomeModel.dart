// To parse this JSON data, do
//
//     final incomeModel = incomeModelFromJson(jsonString);

import 'dart:convert';

List<IncomeModel> incomeModelFromJson(String str) => List<IncomeModel>.from(json.decode(str).map((x) => IncomeModel.fromJson(x)));

String incomeModelToJson(List<IncomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeModel {
  IncomeModel({
    this.house,
    this.payments,
  });

  House house;
  List<Payment> payments;

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
    house: House.fromJson(json["house"]),
    payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "house": house.toJson(),
    "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
  };
}

class House {
  House({
    this.hid,
    this.mid,
    this.houseName,
    this.houseAddress,
    this.houseProvince,
    this.houseDistrict,
    this.houseZipcode,
    this.houseImage,
    this.houseType,
    this.houseFloors,
    this.houseBedroom,
    this.houseBathroom,
    this.houseLivingroom,
    this.houseKitchen,
    this.houseArea,
    this.houseLatitude,
    this.houseLongitude,
    this.houseElectric,
    this.houseWater,
    this.houseRent,
    this.houseDeposit,
    this.houseInsurance,
    this.houseStatus,
  });

  int hid;
  int mid;
  String houseName;
  String houseAddress;
  String houseProvince;
  String houseDistrict;
  int houseZipcode;
  String houseImage;
  String houseType;
  int houseFloors;
  int houseBedroom;
  int houseBathroom;
  int houseLivingroom;
  int houseKitchen;
  String houseArea;
  String houseLatitude;
  String houseLongitude;
  String houseElectric;
  String houseWater;
  int houseRent;
  int houseDeposit;
  int houseInsurance;
  int houseStatus;

  factory House.fromJson(Map<String, dynamic> json) => House(
    hid: json["hid"],
    mid: json["mid"],
    houseName: json["houseName"],
    houseAddress: json["houseAddress"],
    houseProvince: json["houseProvince"],
    houseDistrict: json["houseDistrict"],
    houseZipcode: json["houseZipcode"],
    houseImage: json["houseImage"],
    houseType: json["houseType"],
    houseFloors: json["houseFloors"] == null ? null : json["houseFloors"],
    houseBedroom: json["houseBedroom"] == null ? null : json["houseBedroom"],
    houseBathroom: json["houseBathroom"] == null ? null : json["houseBathroom"],
    houseLivingroom: json["houseLivingroom"] == null ? null : json["houseLivingroom"],
    houseKitchen: json["houseKitchen"] == null ? null : json["houseKitchen"],
    houseArea: json["houseArea"],
    houseLatitude: json["houseLatitude"],
    houseLongitude: json["houseLongitude"],
    houseElectric: json["houseElectric"],
    houseWater: json["houseWater"],
    houseRent: json["houseRent"],
    houseDeposit: json["houseDeposit"],
    houseInsurance: json["houseInsurance"],
    houseStatus: json["houseStatus"],
  );

  Map<String, dynamic> toJson() => {
    "hid": hid,
    "mid": mid,
    "houseName": houseName,
    "houseAddress": houseAddress,
    "houseProvince": houseProvince,
    "houseDistrict": houseDistrict,
    "houseZipcode": houseZipcode,
    "houseImage": houseImage,
    "houseType": houseType,
    "houseFloors": houseFloors == null ? null : houseFloors,
    "houseBedroom": houseBedroom == null ? null : houseBedroom,
    "houseBathroom": houseBathroom == null ? null : houseBathroom,
    "houseLivingroom": houseLivingroom == null ? null : houseLivingroom,
    "houseKitchen": houseKitchen == null ? null : houseKitchen,
    "houseArea": houseArea,
    "houseLatitude": houseLatitude,
    "houseLongitude": houseLongitude,
    "houseElectric": houseElectric,
    "houseWater": houseWater,
    "houseRent": houseRent,
    "houseDeposit": houseDeposit,
    "houseInsurance": houseInsurance,
    "houseStatus": houseStatus,
  };
}

class Payment {
  Payment({
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
  DateTime payHouseDate;
  DateTime payHouseEnd;
  String payHouseImg;
  int payHouseStatus;
  DateTime payElecInmonth;
  String payElecAmount;
  DateTime payElecDate;
  DateTime payElecEnd;
  String payElecImg;
  int payElecStatus;
  DateTime payWaterInmonth;
  String payWaterAmount;
  DateTime payWaterDate;
  DateTime payWaterEnd;
  String payWaterImg;
  int payWaterStatus;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    rid: json["rid"],
    installment: DateTime.parse(json["installment"]),
    payHouseAmount: json["payHouseAmount"],
    payHouseDate: DateTime.parse(json["payHouseDate"]),
    payHouseEnd: DateTime.parse(json["payHouseEnd"]),
    payHouseImg: json["payHouseImg"],
    payHouseStatus: json["payHouseStatus"],
    payElecInmonth: DateTime.parse(json["payElecInmonth"]),
    payElecAmount: json["payElecAmount"],
    payElecDate: json["payElecDate"] == null ? null : DateTime.parse(json["payElecDate"]),
    payElecEnd: DateTime.parse(json["payElecEnd"]),
    payElecImg: json["payElecImg"] == null ? null : json["payElecImg"],
    payElecStatus: json["payElecStatus"],
    payWaterInmonth: DateTime.parse(json["payWaterInmonth"]),
    payWaterAmount: json["payWaterAmount"],
    payWaterDate: json["payWaterDate"] == null ? null : DateTime.parse(json["payWaterDate"]),
    payWaterEnd: DateTime.parse(json["payWaterEnd"]),
    payWaterImg: json["payWaterImg"] == null ? null : json["payWaterImg"],
    payWaterStatus: json["payWaterStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rid": rid,
    "installment": installment.toIso8601String(),
    "payHouseAmount": payHouseAmount,
    "payHouseDate": payHouseDate.toIso8601String(),
    "payHouseEnd": payHouseEnd.toIso8601String(),
    "payHouseImg": payHouseImg,
    "payHouseStatus": payHouseStatus,
    "payElecInmonth": payElecInmonth.toIso8601String(),
    "payElecAmount": payElecAmount,
    "payElecDate": payElecDate == null ? null : payElecDate.toIso8601String(),
    "payElecEnd": payElecEnd.toIso8601String(),
    "payElecImg": payElecImg == null ? null : payElecImg,
    "payElecStatus": payElecStatus,
    "payWaterInmonth": payWaterInmonth.toIso8601String(),
    "payWaterAmount": payWaterAmount,
    "payWaterDate": payWaterDate == null ? null : payWaterDate.toIso8601String(),
    "payWaterEnd": payWaterEnd.toIso8601String(),
    "payWaterImg": payWaterImg == null ? null : payWaterImg,
    "payWaterStatus": payWaterStatus,
  };
}
