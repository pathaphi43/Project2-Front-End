// To parse this JSON data, do
//
//     final transactionShowModel = transactionShowModelFromJson(jsonString);

import 'dart:convert';

List<TransactionShowModel> transactionShowModelFromJson(String str) => List<TransactionShowModel>.from(json.decode(str).map((x) => TransactionShowModel.fromJson(x)));

String transactionShowModelToJson(List<TransactionShowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionShowModel {
  TransactionShowModel({
    this.manager,
    this.house,
    this.tenant,
    this.rentingHouse,
    this.payments,
  });

  dynamic manager;
  House house;
  Tenant tenant;
  dynamic rentingHouse;
  List<Payment> payments;

  factory TransactionShowModel.fromJson(Map<String, dynamic> json) => TransactionShowModel(
    manager: json["manager"],
    house: House.fromJson(json["house"]),
    tenant: Tenant.fromJson(json["tenant"]),
    rentingHouse: json["rentingHouse"],
    payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "manager": manager,
    "house": house.toJson(),
    "tenant": tenant.toJson(),
    "rentingHouse": rentingHouse,
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

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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

class Tenant {
  Tenant({
    this.tid,
    this.tenantUsername,
    this.tenantPassword,
    this.tenantFirstname,
    this.tenantLastname,
    this.tenantPhone,
    this.tenantIdCard,
    this.tenantAddress,
    this.tenantProvince,
    this.tenantDistrict,
    this.tenantEmail,
    this.tenantImage,
    this.tenantStatus,
  });

  int tid;
  String tenantUsername;
  String tenantPassword;
  String tenantFirstname;
  String tenantLastname;
  String tenantPhone;
  String tenantIdCard;
  String tenantAddress;
  String tenantProvince;
  String tenantDistrict;
  String tenantEmail;
  String tenantImage;
  int tenantStatus;

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
    tid: json["tid"],
    tenantUsername: json["tenantUsername"],
    tenantPassword: json["tenantPassword"],
    tenantFirstname: json["tenantFirstname"],
    tenantLastname: json["tenantLastname"],
    tenantPhone: json["tenantPhone"],
    tenantIdCard: json["tenantIdCard"],
    tenantAddress: json["tenantAddress"],
    tenantProvince: json["tenantProvince"],
    tenantDistrict: json["tenantDistrict"],
    tenantEmail: json["tenantEmail"],
    tenantImage: json["tenantImage"],
    tenantStatus: json["tenantStatus"],
  );

  Map<String, dynamic> toJson() => {
    "tid": tid,
    "tenantUsername": tenantUsername,
    "tenantPassword": tenantPassword,
    "tenantFirstname": tenantFirstname,
    "tenantLastname": tenantLastname,
    "tenantPhone": tenantPhone,
    "tenantIdCard": tenantIdCard,
    "tenantAddress": tenantAddress,
    "tenantProvince": tenantProvince,
    "tenantDistrict": tenantDistrict,
    "tenantEmail": tenantEmail,
    "tenantImage": tenantImage,
    "tenantStatus": tenantStatus,
  };
}
