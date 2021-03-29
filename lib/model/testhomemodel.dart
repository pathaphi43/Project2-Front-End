// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Testh> testhFromJson(String str) =>
    List<Testh>.from(json.decode(str).map((x) => Testh.fromJson(x)));

String testhToJson(Testh data) => json.encode(data.toJson());

class Testh {
  Testh({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory Testh.fromJson(Map<String, dynamic> json) => Testh(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
