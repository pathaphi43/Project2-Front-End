// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({this.isUsers, this.email, this.username, this.password, this.token});
  String isUsers;
  String email;
  String username;
  String password;
  String token;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        isUsers: json["isUsers"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "isUsers": isUsers,
        "email": email,
        "username": username,
        "password": password,
        "token": token
      };
}
