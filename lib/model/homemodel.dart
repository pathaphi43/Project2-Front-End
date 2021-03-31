// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<House> houseFromJson(String str) =>
    List<House>.from(json.decode(str).map((x) => House.fromJson(x)));

String houseToJson(List<House> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class House {
  House({
    this.hid,
    this.hManager,
    this.houseName,
    this.houseAdd,
    this.houseImage,
    this.houseStatus,
  });

  int hid;
  int hManager;
  String houseName;
  String houseAdd;
  String houseImage;
  int houseStatus;

  factory House.fromJson(Map<String, dynamic> json) => House(
        hid: json["Hid"],
        hManager: json["h_Manager"],
        houseName: json["house_Name"],
        houseAdd: json["house_Add"],
        houseImage: json["house_Image"],
        houseStatus: json["house_Status"],
      );

  Map<String, dynamic> toJson() => {
        "Hid": hid,
        "h_Manager": hManager,
        "house_Name": houseName,
        "house_Add": houseAdd,
        "house_Image": houseImage,
        "house_Status": houseStatus,
      };
}
