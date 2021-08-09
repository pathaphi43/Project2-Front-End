// To parse this JSON data, do
//
//     final Tombons = TombonsFromJson(jsonString);

import 'dart:convert';

List<Tombons> tombonsFromJson(String str) =>
    List<Tombons>.from(json.decode(str).map((x) => Tombons.fromJson(x)));

String tombonsToJson(List<Tombons> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tombons {
  Tombons({
    this.id,
    this.zipCode,
    this.nameTh,
    this.nameEn,
    this.amphureId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String id;
  String zipCode;
  String nameTh;
  String nameEn;
  String amphureId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  factory Tombons.fromJson(Map<String, dynamic> json) => Tombons(
        id: json["id"],
        zipCode: json["zip_code"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        amphureId: json["amphure_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zip_code": zipCode,
        "name_th": nameTh,
        "name_en": nameEn,
        "amphure_id": amphureId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
