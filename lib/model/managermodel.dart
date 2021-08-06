// To parse this JSON data, do
//
//     final Manager = ManagerFromJson(jsonString);

import 'dart:convert';

List<Manager> managerFromJson(String str) =>
    List<Manager>.from(json.decode(str).map((x) => Manager.fromJson(x)));

String managerToJson(List<Manager> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Manager {
  Manager({
    this.mid,
    this.managerUsername,
    this.managerPassword,
    this.managerFullname,
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
  String managerFullname;
  String managerImage;
  String managerPhone;
  String managerOffice;
  String managerLineid;
  String managerFacebook;
  int managerStatus;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        mid: json["Mid"],
        managerUsername: json["manager_Username"],
        managerPassword: json["manager_Password"],
        managerFullname: json["manager_Fullname"],
        managerImage: json["manager_Image"],
        managerPhone: json["manager_Phone"],
        managerOffice: json["manager_Office"],
        managerLineid: json["manager_Lineid"],
        managerFacebook: json["manager_Facebook"],
        managerStatus: json["manager_Status"],
      );

  Map<String, dynamic> toJson() => {
        "Mid": mid,
        "manager_Username": managerUsername,
        "manager_Password": managerPassword,
        "manager_Fullname": managerFullname,
        "manager_Image": managerImage,
        "manager_Phone": managerPhone,
        "manager_Office": managerOffice,
        "manager_Lineid": managerLineid,
        "manager_Facebook": managerFacebook,
        "manager_Status": managerStatus,
      };
}
