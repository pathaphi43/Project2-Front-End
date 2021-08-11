// To parse this JSON data, do
//
//     final tenant = tenantFromJson(jsonString);

import 'dart:convert';

List<Tenant> tenantFromJson(String str) => List<Tenant>.from(json.decode(str).map((x) => Tenant.fromJson(x)));

String tenantToJson(List<Tenant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tenant {
  Tenant({
    this.tid,
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
    this.tenantImage,
    this.tenantStatus,
  });

  int tid;
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
  String tenantImage;
  int tenantStatus;

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
    tid: json["Tid"],
    tenantUsername: json["tenant_Username"],
    tenantPassword: json["tenant_Password"],
    tenantFirstname: json["tenant_Firstname"],
    tenantLastname: json["tenant_Lastname"],
    tenantPhone: json["tenant_Phone"],
    tenantIDcard: json["tenant_IDcard"],
    tenantAdd: json["tenant_Add"],
    tenantProvince: json["tenant_Province"],
    tenantDistrict: json["tenant_District"] == null ? null : json["tenant_District"],
    tenantEmail: json["tenant_Email"],
    tenantImage: json["tenant_Image"],
    tenantStatus: json["tenant_Status"],
  );

  Map<String, dynamic> toJson() => {
    "Tid": tid,
    "tenant_Username": tenantUsername,
    "tenant_Password": tenantPassword,
    "tenant_Firstname": tenantFirstname,
    "tenant_Lastname": tenantLastname,
    "tenant_Phone": tenantPhone,
    "tenant_IDcard": tenantIDcard,
    "tenant_Add": tenantAdd,
    "tenant_Province": tenantProvince,
    "tenant_District": tenantDistrict == null ? null : tenantDistrict,
    "tenant_Email": tenantEmail,
    "tenant_Image": tenantImage,
    "tenant_Status": tenantStatus,
  };
}
