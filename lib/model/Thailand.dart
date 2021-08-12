import 'dart:convert';

Thailand ThailandFromJson(String str) => Thailand.fromJson(json.decode(str));

String ThailandToJson(Thailand data) => json.encode(data.toJson());

class Thailand {
  Thailand({
    this.name,
    this.id,

  });
  String name;
  String id;



  factory Thailand.fromJson(Map<String, dynamic> json) => Thailand(
    name: json["name"],
    id: json["id"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,

  };
}