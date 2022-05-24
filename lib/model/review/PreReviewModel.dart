// To parse this JSON data, do
//
//     final preReviewModel = preReviewModelFromJson(jsonString);

import 'dart:convert';

List<PreReviewModel> preReviewModelFromJson(String str) => List<PreReviewModel>.from(json.decode(str).map((x) => PreReviewModel.fromJson(x)));

String preReviewModelToJson(List<PreReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreReviewModel {
  PreReviewModel({
    this.house,
    this.rentingHouse,
  });

  House house;
  RentingHouse rentingHouse;

  factory PreReviewModel.fromJson(Map<String, dynamic> json) => PreReviewModel(
    house: House.fromJson(json["house"]),
    rentingHouse: RentingHouse.fromJson(json["rentingHouse"]),
  );

  Map<String, dynamic> toJson() => {
    "house": house.toJson(),
    "rentingHouse": rentingHouse.toJson(),
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

class RentingHouse {
  RentingHouse({
    this.rid,
    this.tid,
    this.hid,
    this.rentingBook,
    this.rentingCheckIn,
    this.rentingCheckOut,
    this.rentingImage,
    this.rentingStatus,
  });

  int rid;
  int tid;
  int hid;
  DateTime rentingBook;
  DateTime rentingCheckIn;
  dynamic rentingCheckOut;
  String rentingImage;
  int rentingStatus;

  factory RentingHouse.fromJson(Map<String, dynamic> json) => RentingHouse(
    rid: json["rid"],
    tid: json["tid"],
    hid: json["hid"],
    rentingBook: DateTime.parse(json["rentingBook"]),
    rentingCheckIn: DateTime.parse(json["rentingCheckIn"]),
    rentingCheckOut: json["rentingCheckOut"],
    rentingImage: json["rentingImage"],
    rentingStatus: json["rentingStatus"],
  );

  Map<String, dynamic> toJson() => {
    "rid": rid,
    "tid": tid,
    "hid": hid,
    "rentingBook": rentingBook.toIso8601String(),
    "rentingCheckIn": rentingCheckIn.toIso8601String(),
    "rentingCheckOut": rentingCheckOut,
    "rentingImage": rentingImage,
    "rentingStatus": rentingStatus,
  };
}
