
import 'dart:convert';

Regmanager regmanagerFromJson(String str) => Regmanager.fromJson(json.decode(str));

String regmanagerToJson(Regmanager data) => json.encode(data.toJson());

class Regmanager {
  Regmanager({
    this.managerUsername,
    this.managerPassword,
    this.managerFirstname,
    this.managerLastname,
    this.managerPhone,
    this.managerOffice,
    this.managerLineid,
    this.managerFacebook,
  });

  String managerUsername;
  String managerPassword;
  String managerFirstname;
  String managerLastname;
  String managerPhone;
  String managerOffice;
  String managerLineid;
  String managerFacebook;

  factory Regmanager.fromJson(Map<String, dynamic> json) => Regmanager(
    managerUsername: json["manager_Username"],
    managerPassword: json["manager_Password"],
    managerFirstname: json["manager_Firstname"],
    managerLastname: json["manager_Lastname"],
    managerPhone: json["manager_Phone"],
    managerOffice: json["manager_Office"],
    managerLineid: json["manager_Lineid"],
    managerFacebook: json["manager_Facebook"],
  );

  Map<String, dynamic> toJson() => {
    "manager_Username": managerUsername,
    "manager_Password": managerPassword,
    "manager_Firstname": managerFirstname,
    "manager_Lastname": managerLastname,
    "manager_Phone": managerPhone,
    "manager_Office": managerOffice,
    "manager_Lineid": managerLineid,
    "manager_Facebook": managerFacebook,
  };
}
