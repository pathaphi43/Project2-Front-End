import 'dart:convert';

List<Tenant> tenantFromJson(String str) =>
    List<Tenant>.from(json.decode(str).map((x) => Tenant.fromJson(x)));

String tenantToJson(List<Tenant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tenant {
  Tenant({
    this.tenantFullname,
    this.tenantPhone,
    this.tenantIDcard,
    this.tenantAdd,
    this.tenantEmail,
    this.tenantImage,
  });

  String tenantFullname;
  String tenantPhone;
  String tenantIDcard;
  String tenantAdd;
  String tenantEmail;
  String tenantImage;

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        tenantFullname: json["tenant_Fullname"],
        tenantPhone: json["tenant_Phone"],
        tenantIDcard: json["tenant_IDcard"],
        tenantAdd: json["tenant_Add"],
        tenantEmail: json["tenant_Email"],
        tenantImage: json["tenant_Image"],
      );

  Map<String, dynamic> toJson() => {
        "tenant_Fullname": tenantFullname,
        "tenant_Phone": tenantPhone,
        "tenant_IDcard": tenantIDcard,
        "tenant_Add": tenantAdd,
        "tenant_Email": tenantEmail,
        "tenant_Image": tenantImage,
      };
}
