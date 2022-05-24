// To parse this JSON data, do
//
//     final regtenant = regtenantFromJson(jsonString);

import 'dart:convert';

Regtenant regtenantFromJson(String str) => Regtenant.fromJson(json.decode(str));

String regtenantToJson(Regtenant data) => json.encode(data.toJson());

class Regtenant {
  Regtenant({
    this.tenantUsername,
    this.tenantPassword,
    this.tenantFirstname,
    this.tenantLastname,
    this.tenantPhone,
    this.tenantIDcard,
    this.tenantAdd,
    this.tenantProvince,
    this.tenantDistrict,
    this.tenantEmail,
  });

  String tenantUsername;
  String tenantPassword;
  String tenantFirstname;
  String tenantLastname;
  String tenantPhone;
  String tenantIDcard;
  String tenantAdd;
  String tenantProvince;
  String tenantDistrict;
  String tenantEmail;

  factory Regtenant.fromJson(Map<String, dynamic> json) => Regtenant(
    tenantUsername: json["tenantUsername"],
    tenantPassword: json["tenantPassword"],
    tenantFirstname: json["tenantFirstname"],
    tenantLastname: json["tenantLastname"],
    tenantPhone: json["tenantPhone"],
    tenantIDcard: json["tenantIdCard"],
    tenantAdd: json["tenantAddress"],
    tenantProvince: json["tenantProvince"],
    tenantDistrict: json["tenantDistrict"],
    tenantEmail: json["tenantEmail"],
  );

  Map<String, dynamic> toJson() => {
    "tenantUsername": tenantUsername,
    "tenantPassword": tenantPassword,
    "tenantFirstname": tenantFirstname,
    "tenantLastname": tenantLastname,
    "tenantPhone": tenantPhone,
    "tenantIdCard": tenantIDcard,
    "tenantAddress": tenantAdd,
    "tenantProvince": tenantProvince,
    "tenantDistrict": tenantDistrict,
    "tenantEmail": tenantEmail,
  };
}
