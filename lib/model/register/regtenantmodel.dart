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
    tenantUsername: json["tenant_Username"],
    tenantPassword: json["tenant_Password"],
    tenantFirstname: json["tenant_Firstname"],
    tenantLastname: json["tenant_Lastname"],
    tenantPhone: json["tenant_Phone"],
    tenantIDcard: json["tenant_IDcard"],
    tenantAdd: json["tenant_Add"],
    tenantProvince: json["tenant_Province"],
    tenantDistrict: json["tenant_District"],
    tenantEmail: json["tenant_Email"],
  );

  Map<String, dynamic> toJson() => {
    "tenant_Username": tenantUsername,
    "tenant_Password": tenantPassword,
    "tenant_Firstname": tenantFirstname,
    "tenant_Lastname": tenantLastname,
    "tenant_Phone": tenantPhone,
    "tenant_IDcard": tenantIDcard,
    "tenant_Add": tenantAdd,
    "tenant_Province": tenantProvince,
    "tenant_District": tenantDistrict,
    "tenant_Email": tenantEmail,
  };
}
