// To parse this JSON data, do
//
//     final house = houseFromJson(jsonString);

import 'dart:convert';

List<House> housesFromJson(String str) => List<House>.from(json.decode(str).map((x) => House.fromJson(x)));
House houseFromJson(String str) => House.fromJson(json.decode(str));
String houseToJson(List<House> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String housesToJson(House data) => json.encode(data.toJson());
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
    houseProvince: json["houseProvince"] == null ? null : json["houseProvince"],
    houseDistrict: json["houseDistrict"] == null ? null : json["houseDistrict"],
    houseZipcode: json["houseZipcode"] == null ? null : json["houseZipcode"],
    houseImage: json["houseImage"],
    houseType: json["houseType"],
    houseFloors: json["houseFloors"] == null ? null : json["houseFloors"],
    houseBedroom: json["houseBedroom"] == null ? null : json["houseBedroom"],
    houseBathroom: json["houseBathroom"] == null ? null : json["houseBathroom"],
    houseLivingroom: json["houseLivingroom"] == null ? null : json["houseLivingroom"],
    houseKitchen: json["houseKitchen"] == null ? null : json["houseKitchen"],
    houseArea: json["houseArea"] == null ? null : json["houseArea"],
    houseLatitude: json["houseLatitude"] == null ? null : json["houseLatitude"],
    houseLongitude: json["houseLongitude"] == null ? null : json["houseLongitude"],
    houseElectric: json["houseElectric"] == null ? null : json["houseElectric"],
    houseWater: json["houseWater"] == null ? null : json["houseWater"],
    houseRent: json["houseRent"] == null ? null : json["houseRent"],
    houseDeposit: json["houseDeposit"] == null ? null : json["houseDeposit"],
    houseInsurance: json["houseInsurance"] == null ? null : json["houseInsurance"],
    houseStatus: json["houseStatus"],
  );

  Map<String, dynamic> toJson() => {
    "hid": hid,
    "mid": mid,
    "houseName": houseName,
    "houseAddress": houseAddress,
    "houseProvince": houseProvince == null ? null : houseProvince,
    "houseDistrict": houseDistrict == null ? null : houseDistrict,
    "houseZipcode": houseZipcode == null ? null : houseZipcode,
    "houseImage": houseImage,
    "houseType": houseType,
    "houseFloors": houseFloors == null ? null : houseFloors,
    "houseBedroom": houseBedroom == null ? null : houseBedroom,
    "houseBathroom": houseBathroom == null ? null : houseBathroom,
    "houseLivingroom": houseLivingroom == null ? null : houseLivingroom,
    "houseKitchen": houseKitchen == null ? null : houseKitchen,
    "houseArea": houseArea == null ? null : houseArea,
    "houseLatitude": houseLatitude == null ? null : houseLatitude,
    "houseLongitude": houseLongitude == null ? null : houseLongitude,
    "houseElectric": houseElectric == null ? null : houseElectric,
    "houseWater": houseWater == null ? null : houseWater,
    "houseRent": houseRent == null ? null : houseRent,
    "houseDeposit": houseDeposit == null ? null : houseDeposit,
    "houseInsurance": houseInsurance == null ? null : houseInsurance,
    "houseStatus": houseStatus,
  };
}
