// To parse this JSON data, do
//
//     final edithouse = edithouseFromJson(jsonString);

import 'dart:convert';

Edithouse edithouseFromJson(String str) => Edithouse.fromJson(json.decode(str));

String edithouseToJson(Edithouse data) => json.encode(data.toJson());

class Edithouse {
  Edithouse({
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
    this.hid,
  });

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
  String houseArea;
  String houseLatitude;
  String houseLongitude;
  String houseElectric;
  String houseWater;
  int houseRent;
  int houseDeposit;
  int houseInsurance;
  int houseStatus;
  int hid;

  factory Edithouse.fromJson(Map<String, dynamic> json) => Edithouse(
    houseName: json["house_Name"],
    houseAdd: json["house_Add"],
    houseProvince: json["house_Province"],
    houseDistrict: json["house_District"],
    houseZipcode: json["house_Zipcode"],
    houseType: json["house_Type"],
    houseFloors: json["house_Floors"],
    houseBedroom: json["house_Bedroom"],
    houseBathroom: json["house_Bathroom"],
    houseLivingroom: json["house_Livingroom"],
    houseKitchen: json["house_Kitchen"],
    houseArea: json["house_Area"],
    houseLatitude: json["house_Latitude"],
    houseLongitude: json["house_Longitude"],
    houseElectric: json["house_Electric"],
    houseWater: json["house_Water"],
    houseRent: json["house_Rent"],
    houseDeposit: json["house_Deposit"],
    houseInsurance: json["house_Insurance"],
    houseStatus: json["house_Status"],
    hid: json["Hid"],
  );

  Map<String, dynamic> toJson() => {
    "house_Name": houseName,
    "house_Add": houseAdd,
    "house_Province": houseProvince,
    "house_District": houseDistrict,
    "house_Zipcode": houseZipcode,
    "house_Type": houseType,
    "house_Floors": houseFloors,
    "house_Bedroom": houseBedroom,
    "house_Bathroom": houseBathroom,
    "house_Livingroom": houseLivingroom,
    "house_Kitchen": houseKitchen,
    "house_Area": houseArea,
    "house_Latitude": houseLatitude,
    "house_Longitude": houseLongitude,
    "house_Electric": houseElectric,
    "house_Water": houseWater,
    "house_Rent": houseRent,
    "house_Deposit": houseDeposit,
    "house_Insurance": houseInsurance,
    "house_Status": houseStatus,
    "Hid": hid,
  };
}
