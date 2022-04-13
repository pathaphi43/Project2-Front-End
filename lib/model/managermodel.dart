// To parse this JSON data, do
//
//     final manager = managerFromJson(jsonString);

import 'dart:convert';

Manager managerFromJson(String str) => Manager.fromJson(json.decode(str));

String managerToJson(Manager data) => json.encode(data.toJson());

class Manager {
  Manager({
    this.mid,
    this.managerUsername,
    this.managerPassword,
    this.managerFirstname,
    this.managerLastname,
    this.managerImage,
    this.managerPhone,
    this.managerOffice,
    this.managerLineid,
    this.managerFacebook,
    this.managerStatus,
  });

  int mid;
  String managerUsername;
  String managerPassword;
  String managerFirstname;
  String managerLastname;
  String managerImage;
  String managerPhone;
  String managerOffice;
  String managerLineid;
  String managerFacebook;
  int managerStatus;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    mid: json["mid"],
    managerUsername: json["managerUsername"],
    managerPassword: json["managerPassword"],
    managerFirstname: json["managerFirstname"],
    managerLastname: json["managerLastname"],
    managerImage: json["managerImage"],
    managerPhone: json["managerPhone"],
    managerOffice: json["managerOffice"],
    managerLineid: json["managerLineid"],
    managerFacebook: json["managerFacebook"],
    managerStatus: json["managerStatus"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "managerUsername": managerUsername,
    "managerPassword": managerPassword,
    "managerFirstname": managerFirstname,
    "managerLastname": managerLastname,
    "managerImage": managerImage,
    "managerPhone": managerPhone,
    "managerOffice": managerOffice,
    "managerLineid": managerLineid,
    "managerFacebook": managerFacebook,
    "managerStatus": managerStatus,
  };
}
