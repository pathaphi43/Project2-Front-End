// To parse this JSON data, do
//
//     final tenant = tenantFromJson(jsonString);

import 'dart:convert';

Tenant tenantFromJson(String str) => Tenant.fromJson(json.decode(str));

String tenantToJson(Tenant data) => json.encode(data.toJson());

class Tenant {
  Tenant({
    this.tid,
    this.tenantUsername,
    this.tenantPassword,
    this.tenantFirstname,
    this.tenantLastname,
    this.tenantPhone,
    this.tenantIdCard,
    this.tenantAddress,
    this.tenantProvince,
    this.tenantDistrict,
    this.tenantEmail,
    this.tenantImage,
    this.tenantStatus,
  });

  int tid;
  String tenantUsername;
  String tenantPassword;
  String tenantFirstname;
  String tenantLastname;
  String tenantPhone;
  String tenantIdCard;
  String tenantAddress;
  String tenantProvince;
  String tenantDistrict;
  String tenantEmail;
  String tenantImage;
  int tenantStatus;

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
    tid: json["tid"],
    tenantUsername: json["tenantUsername"],
    tenantPassword: json["tenantPassword"],
    tenantFirstname: json["tenantFirstname"],
    tenantLastname: json["tenantLastname"],
    tenantPhone: json["tenantPhone"],
    tenantIdCard: json["tenantIdCard"],
    tenantAddress: json["tenantAddress"],
    tenantProvince: json["tenantProvince"],
    tenantDistrict: json["tenantDistrict"],
    tenantEmail: json["tenantEmail"],
    tenantImage: json["tenantImage"],
    tenantStatus: json["tenantStatus"],
  );

  Map<String, dynamic> toJson() => {
    "tid": tid,
    "tenantUsername": tenantUsername,
    "tenantPassword": tenantPassword,
    "tenantFirstname": tenantFirstname,
    "tenantLastname": tenantLastname,
    "tenantPhone": tenantPhone,
    "tenantIdCard": tenantIdCard,
    "tenantAddress": tenantAddress,
    "tenantProvince": tenantProvince,
    "tenantDistrict": tenantDistrict,
    "tenantEmail": tenantEmail,
    "tenantImage": tenantImage,
    "tenantStatus": tenantStatus,
  };
}
