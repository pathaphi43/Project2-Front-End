// To parse this JSON data, do
//
//     final editmanager = editmanagerFromJson(jsonString);

import 'dart:convert';

Editmanager editmanagerFromJson(String str) => Editmanager.fromJson(json.decode(str));

String editmanagerToJson(Editmanager data) => json.encode(data.toJson());

class Editmanager {
  Editmanager({
    this.managerFirstname,
    this.managerLastname,
    this.managerImage,
    this.managerPhone,
    this.managerOffice,
    this.managerLineid,
    this.managerFacebook,
    this.managerStatus,
    this.mid,
  });

  String managerFirstname;
  String managerLastname;
  String managerImage;
  String managerPhone;
  String managerOffice;
  String managerLineid;
  String managerFacebook;
  int managerStatus;
  int mid;

  factory Editmanager.fromJson(Map<String, dynamic> json) => Editmanager(
    managerFirstname: json["manager_Firstname"],
    managerLastname: json["manager_Lastname"],
    managerImage: json["manager_Image"],
    managerPhone: json["manager_Phone"],
    managerOffice: json["manager_Office"],
    managerLineid: json["manager_Lineid"],
    managerFacebook: json["manager_Facebook"],
    managerStatus: json["manager_Status"],
    mid: json["Mid"],
  );

  Map<String, dynamic> toJson() => {
    "manager_Firstname": managerFirstname,
    "manager_Lastname": managerLastname,
    "manager_Image": managerImage,
    "manager_Phone": managerPhone,
    "manager_Office": managerOffice,
    "manager_Lineid": managerLineid,
    "manager_Facebook": managerFacebook,
    "manager_Status": managerStatus,
    "Mid": mid,
  };
}
