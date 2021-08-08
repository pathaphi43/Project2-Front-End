// To parse this JSON data, do
//
//     final House = HouseFromJson(jsonString);

import 'dart:convert';

List<House> houseFromJson(String str) =>
    List<House>.from(json.decode(str).map((x) => House.fromJson(x)));

String houseToJson(List<House> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class House {
  House({
    this.hid,
    this.hManager,
    this.houseName,
    this.houseAdd,
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
  int hManager;
  String houseName;
  String houseAdd;
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
        hid: json["Hid"],
        hManager: json["h_Manager"],
        houseName: json["house_Name"],
        houseAdd: json["house_Add"],
        houseProvince:
            json["house_Province"] == null ? null : json["house_Province"],
        houseDistrict:
            json["house_District"] == null ? null : json["house_District"],
        houseZipcode:
            json["house_Zipcode"] == null ? null : json["house_Zipcode"],
        houseImage: json["house_Image"],
        houseType: json["house_Type"] == null ? null : json["house_Type"],
        houseFloors: json["house_Floors"] == null ? null : json["house_Floors"],
        houseBedroom:
            json["house_Bedroom"] == null ? null : json["house_Bedroom"],
        houseBathroom:
            json["house_Bathroom"] == null ? null : json["house_Bathroom"],
        houseLivingroom:
            json["house_Livingroom"] == null ? null : json["house_Livingroom"],
        houseKitchen:
            json["house_Kitchen"] == null ? null : json["house_Kitchen"],
        houseArea: json["house_Area"] == null ? null : json["house_Area"],
        houseLatitude:
            json["house_Latitude"] == null ? null : json["house_Latitude"],
        houseLongitude:
            json["house_Longitude"] == null ? null : json["house_Longitude"],
        houseElectric:
            json["house_Electric"] == null ? null : json["house_Electric"],
        houseWater: json["house_Water"] == null ? null : json["house_Water"],
        houseRent: json["house_Rent"] == null ? null : json["house_Rent"],
        houseDeposit:
            json["house_Deposit"] == null ? null : json["house_Deposit"],
        houseInsurance:
            json["house_Insurance"] == null ? null : json["house_Insurance"],
        houseStatus: json["house_Status"],
      );

  Map<String, dynamic> toJson() => {
        "Hid": hid,
        "h_Manager": hManager,
        "house_Name": houseName,
        "house_Add": houseAdd,
        "house_Province": houseProvince == null ? null : houseProvince,
        "house_District": houseDistrict == null ? null : houseDistrict,
        "house_Zipcode": houseZipcode == null ? null : houseZipcode,
        "house_Image": houseImage,
        "house_Type": houseType == null ? null : houseType,
        "house_Floors": houseFloors == null ? null : houseFloors,
        "house_Bedroom": houseBedroom == null ? null : houseBedroom,
        "house_Bathroom": houseBathroom == null ? null : houseBathroom,
        "house_Livingroom": houseLivingroom == null ? null : houseLivingroom,
        "house_Kitchen": houseKitchen == null ? null : houseKitchen,
        "house_Area": houseArea == null ? null : houseArea,
        "house_Latitude": houseLatitude == null ? null : houseLatitude,
        "house_Longitude": houseLongitude == null ? null : houseLongitude,
        "house_Electric": houseElectric == null ? null : houseElectric,
        "house_Water": houseWater == null ? null : houseWater,
        "house_Rent": houseRent == null ? null : houseRent,
        "house_Deposit": houseDeposit == null ? null : houseDeposit,
        "house_Insurance": houseInsurance == null ? null : houseInsurance,
        "house_Status": houseStatus,
      };
}
