// To parse this JSON data, do
//
//     final rentModel = rentModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

RentModel rentModelFromJson(String str) => RentModel.fromJson(json.decode(str));

String rentModelToJson(RentModel data) => json.encode(data.toJson());

class RentModel {
  RentModel({
    this.rid,
    this.hid,
    this.tid,
    this.rentingBook,
    this.rentingCheckIn,
    this.rentingCheckOut,
    this.rentingImage,
    this.rentingStatus,
    this.mid,
    this.houseName,
    this.houseAddress,
    this.houseProvince,
    this.houseDistrict,
    this.houseLatitude,
    this.houseLongitude,
    this.houseElectric,
    this.houseWater,
    this.houseRent,
    this.houseDeposit,
    this.houseInsurance,
    this.houseStatus,
    this.tenantUsername,
    this.tenantFirstname,
    this.tenantLastname,
    this.tenantPhone,
    this.tenantAddress,
    this.tenantProvince,
    this.tenantDistrict,
    this.tenantImage,
    this.tenantStatus,
    this.file
  });

  int rid;
  int hid;
  int tid;
  String rentingBook;
  String rentingCheckIn;
  String rentingCheckOut;
  String rentingImage;
  int rentingStatus;
  int mid;
  String houseName;
  String houseAddress;
  String houseProvince;
  String houseDistrict;
  String houseLatitude;
  String houseLongitude;
  String houseElectric;
  String houseWater;
  int houseRent;
  int houseDeposit;
  int houseInsurance;
  int houseStatus;
  String tenantUsername;
  String tenantFirstname;
  String tenantLastname;
  String tenantPhone;
  String tenantAddress;
  String tenantProvince;
  String tenantDistrict;
  String tenantImage;
  int tenantStatus;
  MultipartFile file;

  factory RentModel.fromJson(Map<String, dynamic> json) => RentModel(
    rid: json["rid"],
    hid: json["hid"],
    tid: json["tid"],
    rentingBook: json["rentingBook"] == null ? null : json["rentingBook"],
    rentingCheckIn: json["rentingCheckIn"] == null ? null : json["rentingCheckIn"],
    rentingCheckOut: json["rentingCheckOut"] == null ? null : json["rentingCheckOut"],
    rentingImage: json["rentingImage"] == null ? null : json["rentingImage"],
    rentingStatus: json["rentingStatus"] == null ? null : json["rentingStatus"],
    mid: json["mid"] == null ? null : json["mid"],
    houseName: json["houseName"] == null ? null : json["houseName"],
    houseAddress: json["houseAddress"] == null ? null : json["houseAddress"],
    houseProvince: json["houseProvince"] == null ? null : json["houseProvince"],
    houseDistrict: json["houseDistrict"] == null ? null : json["houseDistrict"],
    houseLatitude: json["houseLatitude"] == null ? null : json["houseLatitude"],
    houseLongitude: json["houseLongitude"] == null ? null : json["houseLongitude"],
    houseElectric: json["houseElectric"] == null ? null : json["houseElectric"],
    houseWater: json["houseWater"] == null ? null : json["houseWater"],
    houseRent: json["houseRent"] == null ? null : json["houseRent"],
    houseDeposit: json["houseDeposit"] == null ? null : json["houseDeposit"],
    houseInsurance: json["houseInsurance"] == null ? null : json["houseInsurance"],
    houseStatus: json["houseStatus"],
    tenantUsername: json["tenantUsername"] == null ? null : json["tenantUsername"],
    tenantFirstname: json["tenantFirstname"] == null ? null : json["tenantFirstname"],
    tenantLastname: json["tenantLastname"] == null ? null : json["tenantLastname"],
    tenantPhone: json["tenantPhone"] == null ? null : json["tenantPhone"],
    tenantAddress: json["tenantAddress"] == null ? null : json["tenantAddress"],
    tenantProvince: json["tenantProvince"] == null ? null : json["tenantProvince"],
    tenantDistrict: json["tenantDistrict"] == null ? null : json["tenantDistrict"],
    tenantImage: json["tenantImage"] == null ? null : json["tenantImage"],
    tenantStatus: json["tenantStatus"],
    file: json['file']

  );

  Map<String, dynamic> toJson() => {
    "rid": rid,
    "hid": hid,
    "tid": tid,
    "rentingBook": rentingBook == null ? null : rentingBook,
    "rentingCheckIn": rentingCheckIn == null ? null : rentingCheckIn,
    "rentingCheckOut": rentingCheckOut == null ? null : rentingCheckOut,
    "rentingImage": rentingImage == null ? null : rentingImage,
    "rentingStatus": rentingStatus == null ? null : rentingStatus,
    "mid": mid == null ? null : mid,
    "houseName": houseName == null ? null : houseName,
    "houseAddress": houseAddress == null ? null : houseAddress,
    "houseProvince": houseProvince == null ? null : houseProvince,
    "houseDistrict": houseDistrict == null ? null : houseDistrict,
    "houseLatitude": houseLatitude == null ? null : houseLatitude,
    "houseLongitude": houseLongitude == null ? null : houseLongitude,
    "houseElectric": houseElectric == null ? null : houseElectric,
    "houseWater": houseWater == null ? null : houseWater,
    "houseRent": houseRent == null ? null : houseRent,
    "houseDeposit": houseDeposit == null ? null : houseDeposit,
    "houseInsurance": houseInsurance == null ? null : houseInsurance,
    "houseStatus": houseStatus,
    "tenantUsername": tenantUsername == null ? null : tenantUsername,
    "tenantFirstname": tenantFirstname == null ? null : tenantFirstname,
    "tenantLastname": tenantLastname == null ? null : tenantLastname,
    "tenantPhone": tenantPhone == null ? null : tenantPhone,
    "tenantAddress": tenantAddress == null ? null : tenantAddress,
    "tenantProvince": tenantProvince == null ? null : tenantProvince,
    "tenantDistrict": tenantDistrict == null ? null : tenantDistrict,
    "tenantImage": tenantImage == null ? null : tenantImage,
    "tenantStatus": tenantStatus,
    "file":file
  };
}
