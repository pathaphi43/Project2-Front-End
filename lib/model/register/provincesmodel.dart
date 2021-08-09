// To parse this JSON data, do
//
//     final Provinces = ProvincesFromJson(jsonString);

import 'dart:convert';

List<Provinces> provincesFromJson(String str) =>
    List<Provinces>.from(json.decode(str).map((x) => Provinces.fromJson(x)));

String provincesToJson(List<Provinces> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Provinces {
  Provinces({
    this.id,
    this.nameTh,
    this.nameEn,
    this.geographyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String nameTh;
  String nameEn;
  String geographyId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  factory Provinces.fromJson(Map<String, dynamic> json) => Provinces(
        id: json["id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        geographyId: json["geography_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_th": nameTh,
        "name_en": nameEn,
        "geography_id": geographyId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
