import 'dart:convert';

AmphureThailand AmphureThailandFromJson(String str) => AmphureThailand.fromJson(json.decode(str));

String AmphureThailandToJson(AmphureThailand data) => json.encode(data.toJson());

class AmphureThailand {
  AmphureThailand({
    this.name,
    this.id,

  });
  String name;
  String id;



  factory AmphureThailand.fromJson(Map<String, dynamic> json) => AmphureThailand(
    name: json["name"],
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,

  };
}