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
    hManager: json["h_Manager"],
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
  );

  Map<String, dynamic> toJson() => {
    "h_Manager": hManager,
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
  };
}
