// To parse this JSON data, do
//
//     final inserthouse = inserthouseFromJson(jsonString);

import 'dart:convert';

Inserthouse inserthouseFromJson(String str) => Inserthouse.fromJson(json.decode(str));

String inserthouseToJson(Inserthouse data) => json.encode(data.toJson());

class Inserthouse {
  Inserthouse({
    this.hManager,
    this.houseName,
    this.houseAdd,
    this.houseProvince,
    this.houseDistrict,
    this.houseZipcode,
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
    this.houseImage
  });

  int hManager;
  String houseName;
  String houseAdd;
  String houseProvince;
  String houseDistrict;
  int houseZipcode;
  String houseType;
  int houseFloors;
  int houseBedroom;
  int houseBathroom;
  int houseLivingroom;
  int houseKitchen;
  String houseImage;
  String houseArea;
  String houseLatitude;
  String houseLongitude;
  String houseElectric;
  String houseWater;
  int houseRent;
  int houseDeposit;
  int houseInsurance;
  int houseStatus;

  factory Inserthouse.fromJson(Map<String, dynamic> json) => Inserthouse(
    hManager: json["mid"],
    houseName: json["houseName"],
    houseAdd: json["houseAddress"],
    houseProvince: json["houseProvince"],
    houseDistrict: json["houseDistrict"],
    houseZipcode: json["houseZipcode"],
    houseType: json["houseType"],
    houseFloors: json["houseFloors"],
    houseBedroom: json["houseBedroom"],
    houseBathroom: json["houseBathroom"],
    houseLivingroom: json["houseLivingroom"],
    houseKitchen: json["houseKitchen"],
    houseArea: json["houseArea"],
    houseLatitude: json["houseLatitude"],
    houseLongitude: json["houseLongitude"],
    houseElectric: json["houseElectric"],
    houseWater: json["houseWater"],
    houseRent: json["houseRent"],
    houseDeposit: json["houseDeposit"],
    houseInsurance: json["houseInsurance"],
    houseImage: json["houseImage"],
    houseStatus: json["houseStatus"],
  );

  Map<String, dynamic> toJson() => {
    "mid": hManager,
    "houseName": houseName,
    "houseAddress": houseAdd,
    "houseProvince": houseProvince,
    "houseDistrict": houseDistrict,
    "houseZipcode": houseZipcode,
    "houseType": houseType,
    "houseFloors": houseFloors,
    "houseBedroom": houseBedroom,
    "houseBathroom": houseBathroom,
    "houseLivingroom": houseLivingroom,
    "houseKitchen": houseKitchen,
    "houseArea": houseArea,
    "houseLatitude": houseLatitude,
    "houseLongitude": houseLongitude,
    "houseElectric": houseElectric,
    "houseWater": houseWater,
    "houseRent": houseRent,
    "houseDeposit": houseDeposit,
    "houseInsurance": houseInsurance,
    "houseImage":houseImage,
    "houseStatus": houseStatus,
  };
}
