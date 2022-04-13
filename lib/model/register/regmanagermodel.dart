
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
    managerUsername: json["managerUsername"],
    managerPassword: json["managerPassword"],
    managerFirstname: json["managerFirstname"],
    managerLastname: json["managerLastname"],
    managerPhone: json["managerPhone"],
    managerOffice: json["managerOffice"],
    managerLineid: json["managerLineid"],
    managerFacebook: json["managerFacebook"],
  );

  Map<String, dynamic> toJson() => {
    "managerUsername": managerUsername,
    "managerPassword": managerPassword,
    "managerFirstname": managerFirstname,
    "managerLastname": managerLastname,
    "managerPhone": managerPhone,
    "managerOffice": managerOffice,
    "managerLineid": managerLineid,
    "managerFacebook": managerFacebook,
  };
}
