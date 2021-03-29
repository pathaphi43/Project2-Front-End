// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({this.email, this.username, this.password, this.token});

  String email;
  String username;
  String password;
  String token;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        username: json["username"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
        "token": token
      };
}
