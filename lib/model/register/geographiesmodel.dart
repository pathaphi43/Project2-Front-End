// To parse this JSON data, do
//
//     final Geograp = GeograpFromJson(jsonString);

import 'dart:convert';

List<Geograp> geograpFromJson(String str) =>
    List<Geograp>.from(json.decode(str).map((x) => Geograp.fromJson(x)));

String geograpToJson(List<Geograp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Geograp {
  Geograp({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Geograp.fromJson(Map<String, dynamic> json) => Geograp(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
