import 'dart:convert';

Inhouse inhouseFromJson(String str) => Inhouse.fromJson(json.decode(str));

String inhouseToJson(Inhouse data) => json.encode(data.toJson());

class Inhouse {
  Inhouse({
    this.hManager,
    this.houseName,
    this.houseAdd,
    this.houseStatus,
  });

  int hManager;
  String houseName;
  String houseAdd;
  int houseStatus;

  factory Inhouse.fromJson(Map<String, dynamic> json) => Inhouse(
        hManager: json["h_Manager"],
        houseName: json["house_Name"],
        houseAdd: json["house_Add"],
        houseStatus: json["house_Status"],
      );

  Map<String, dynamic> toJson() => {
        "h_Manager": hManager,
        "house_Name": houseName,
        "house_Add": houseAdd,
        "house_Status": houseStatus,
      };
}
