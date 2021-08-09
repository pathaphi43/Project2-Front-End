// To parse this JSON data, do
//
//     final Amphures = AmphuresFromJson(jsonString);

import 'dart:convert';

List<Amphures> amphuresFromJson(String str) =>
    List<Amphures>.from(json.decode(str).map((x) => Amphures.fromJson(x)));

String aAmphuresToJson(List<Amphures> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Amphures {
  Amphures({
    this.id,
    this.nameTh,
    this.nameEn,
    this.provinceId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String nameTh;
  String nameEn;
  String provinceId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  factory Amphures.fromJson(Map<String, dynamic> json) => Amphures(
        id: json["id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        provinceId: json["province_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_th": nameTh,
        "name_en": nameEn,
        "province_id": provinceId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
