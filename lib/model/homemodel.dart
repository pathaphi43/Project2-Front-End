// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

House houseFromJson(String str) => House.fromJson(json.decode(str));

String houseToJson(House data) => json.encode(data.toJson());

class House {
  House({
    this.hid,
    this.houseName,
    this.houseAdd,
    this.houseStatus,
  });

  int hid;
  String houseName;
  String houseAdd;
  int houseStatus;

  factory House.fromJson(Map<String, dynamic> json) => House(
        hid: json["Hid"],
        houseName: json["house_Name"],
        houseAdd: json["house_Add"],
        houseStatus: json["house_Status"],
      );

  Map<String, dynamic> toJson() => {
        "Hid": hid,
        "house_Name": houseName,
        "house_Add": houseAdd,
        "house_Status": houseStatus,
      };
}
