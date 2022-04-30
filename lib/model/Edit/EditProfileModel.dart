// To parse this JSON data, do
//
//     final editProfile = editProfileFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

EditProfile editProfileFromJson(String str) => EditProfile.fromJson(json.decode(str));

String editProfileToJson(EditProfile data) => json.encode(data.toJson());

class EditProfile {
  EditProfile({
    this.managerId,
    this.file,
  });

  String managerId;
  File file;

  factory EditProfile.fromJson(Map<String, dynamic> json) => EditProfile(
    managerId: json["managerId"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "managerId": managerId,
    "file": file,
  };
}
